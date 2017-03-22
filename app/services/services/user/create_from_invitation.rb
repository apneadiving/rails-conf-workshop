module Services
  module User
    class CreateFromInvitation

      include Waterfall

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        with_transaction do
          when_falsy { invitee.save }
            .dam { invitee.errors }
          when_falsy do
            invitation.update(invitee: invitee)
          end
            .dam { invitation.errors }
          chain do
            AppMailer.welcome_email(invitee).deliver_later
          end
          chain(:invitee) { invitee }
        end
      end

      private

      attr_reader :invitation

      def invitee
        @invitee ||= ::User.new(
          email: invitation.invitee_email
        )
      end
    end
  end
end