module Services
  module Invitation
    class Accept

      attr_reader :invitation

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        create_service = ::Services::User::CreateFromInvitation.new(invitation)
        create_service.call
        invitation.accepted = true
        invitation.save
        Services::User::Credit.new(user: invitation.inviter, cents: REFERRER_FEE_IN_CENTS, source: invitation).call
      end

      def user
        create_service.user
      end

      private

      REFERRER_FEE_IN_CENTS = 500

      attr_reader :invitation
    end
  end
end