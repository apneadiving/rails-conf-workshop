module Services
  module User
    class Credit

      include ActiveModel::Validations

      def initialize(user:, cents:, source:)
        @user, @cents, @source = user, cents, source
      end

      def call
        credit = CreditTransaction.create(user: user, source: source, cents: cents)
        AppMailer.notify_payment(credit).deliver_later if credit.persisted?
      end

      private

      attr_reader :user, :cents, :source
    end
  end
end