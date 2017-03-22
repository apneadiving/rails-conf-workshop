module Services
  module User
    class CreateFromInvitation

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        # goal:
        # - remove email sending from user model
        # - remove import_context from User model
        # - remove after create altogether
        ::User.create_from_invitation(invitation)
      end

      private

      attr_reader :invitation
    end
  end
end