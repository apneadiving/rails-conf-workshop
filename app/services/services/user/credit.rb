module Services
  module User
    class Credit

      include ActiveModel::Validations

      def initialize(user:, cents:, source:)
        @user, @cents, @source = user, cents, source
      end

      def call
        credit = CreditTransaction.create(user: user, source: source, cents: cents)
        if credit.persisted?
          AppMailer.notify_payment(credit).deliver_later
        else
          @issues = credit.errors
        end
      end

      attr_reader :issues

      def success?
        @issues.blank?
      end

      private

      attr_reader :user, :cents, :source
    end
  end
end