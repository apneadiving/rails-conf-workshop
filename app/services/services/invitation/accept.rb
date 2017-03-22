module Services
  module Invitation
    class Accept

      include Waterfall

      AFFILATION_EARNING_CENTS = 500

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        with_transaction do
          chain do
            ::Services::User::CreateFromInvitation.new(invitation)
          end
          chain do
            ::Services::User::Credit.new(
              user:   invitation.inviter,
              cents:  AFFILATION_EARNING_CENTS,
              source: invitation
            )
          end
          when_falsy { invitation.accept.save }
            .dam { invitation.errors }
        end
      end

      private

      attr_reader :invitation
    end
  end
end