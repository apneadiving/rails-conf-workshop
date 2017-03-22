module Services
  module Invitation
    class Create

      attr_reader :invitation

      def initialize(inviter:, email:)
        @inviter, @invitee_email = inviter, email
      end

      def call
        # remove after create callback from invitation
        @invitation = ::Invitation.create(
          inviter: inviter,
          invitee_email: invitee_email
        )
      end

      private

      attr_reader :inviter, :invitee_email
    end
  end
end