module Services
  module Invitation
    class Accept

      attr_reader :invitation

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        # would host code from invitations_controller
      end

      private

      attr_reader :invitation
    end
  end
end