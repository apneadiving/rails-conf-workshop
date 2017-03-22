module Factories

  class << self

    def create_user(params = nil)
      ::User.create!(params || default_user_params)
    end

    def create_invitation(params = nil)
      ::Invitation.create!(params || default_invitation_params)
    end

    private

    def default_user_params
      {
        email: "foo-#{ SecureRandom.uuid }@example.com",
        name:  'john doe'
      }
    end

    def default_invitation_params
      {
        inviter: create_user,
        invitee_email: 'invitee@example.com'
      }
    end
  end

end
