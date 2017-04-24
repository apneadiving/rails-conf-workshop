module Services
  module User
    class Credit

      include ActiveModel::Validations
      include Waterfall

      def initialize(user:, cents:, source:)
        @user, @cents, @source = user, cents, source
      end

      def call
        chain { @credit = CreditTransaction.create(user: user, source: source, cents: cents) }
        when_falsy { credit.persisted? }
          .dam { credit.errors }
        chain { AppMailer.notify_payment(credit).deliver_later }
      end

      private

      attr_reader :user, :cents, :source, :credit
    end
  end
end