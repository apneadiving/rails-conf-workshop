module Services
  module User
    class CreateFromInvitation

      include Waterfall

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        with_transaction do
          chain(:user) { create_user }
          when_falsy { invitation.update(invitee: user) }
            .dam { invitation.errors }
          chain { send_email }
        end
      end

      private

      def create_user
        @user = ::User.create(email: invitation.invitee_email)
      end

      def send_email
        AppMailer.welcome_email(user).deliver_later
      end

      attr_reader :invitation, :user
    end
  end
end