module Services
  module User
    class CreateFromInvitation

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        create_user
        update_invitation
        send_email
      end

      attr_reader :user

      private

      def create_user
        @user = ::User.create(email: invitation.invitee_email)
      end

      def update_invitation
        invitation.update(invitee: user)
      end

      def send_email
        AppMailer.welcome_email(user).deliver_later
      end

      attr_reader :invitation
    end
  end
end