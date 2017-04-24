module Services
  module Invitation
    class Create

      attr_reader :invitation

      def initialize(inviter:, email:)
        @inviter, @invitee_email = inviter, email
      end

      def call
        @invitation = ::Invitation.create(
          inviter: inviter,
          invitee_email: invitee_email
        )

        send_invitation_email if invitation.persisted?
      end

      private

      def send_invitation_email
        AppMailer.invitation_email(invitation).deliver_later
      end

      attr_reader :inviter, :invitee_email
    end
  end
end