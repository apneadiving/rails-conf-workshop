module Services
  module User
    class CreateFromInvitation

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        create_user
        if success?
          update_invitation
          if success?
            send_email
          end
        end
      end

      attr_reader :user, :issues

      def success?
        @issues.blank?
      end

      private

      def create_user
        @user = ::User.create(email: invitation.invitee_email)
        @issues = user.errors unless user.persisted?
      end

      def update_invitation
        unless invitation.update(invitee: user)
          @issues = invitation.errors
        end
      end

      def send_email
        AppMailer.welcome_email(user).deliver_later
      end

      attr_reader :invitation
    end
  end
end