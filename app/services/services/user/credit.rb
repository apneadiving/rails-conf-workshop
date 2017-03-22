module Services
  module User
    class Credit

      include Waterfall

      def initialize(user:, cents:, source:)
        @user, @cents, @source = user, cents, source
      end

      def call
        with_transaction do
          when_falsy { credit.valid? }
            .dam { credit.errors }
          chain do
            AppMailer.notify_payment(credit).deliver_later
          end
        end
      end

      private

      attr_reader :user, :cents, :source

      def credit
        @credit ||= CreditTransaction.create(user: user, source: source, cents: cents)
      end
    end
  end
end