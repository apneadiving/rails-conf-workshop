module Services
  module Invitation
    class Create

      include Waterfall

      def initialize(inviter:, email:)
        @inviter, @invitee_email = inviter, email
      end

      def call
        when_falsy { invitation.save }
          .dam { invitation.errors }
        chain do
          AppMailer.invitation_email(invitation).deliver_later
        end
        chain(:invitation) { invitation }
      end

      private

      attr_reader :inviter, :invitee_email

      def invitation
        @invitation ||= ::Invitation.new(
          inviter: inviter,
          invitee_email: invitee_email
        )
      end
    end
  end
end