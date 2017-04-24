module Services
  module Invitation
    class Accept

      attr_reader :invitation

      include ActiveModel::Validations
      include Waterfall

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        with_transaction do
          when_truthy { invitation.accepted? }
            .dam do
              errors.add :status, 'Invitation already accepted'
              errors
            end

          chain(user: :user) { ::Services::User::CreateFromInvitation.new(invitation) }
          when_falsy { invitation.accept.save }
            .dam { invitation.errors }
          chain { Services::User::Credit.new(user: invitation.inviter, cents: REFERRER_FEE_IN_CENTS, source: invitation) }
        end
      end

      private

      REFERRER_FEE_IN_CENTS = 500

      attr_reader :invitation
    end
  end
end