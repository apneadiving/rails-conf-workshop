module Services
  module User
    class Signup

      include ActiveModel::Validations

      validates :name,  presence: true

      def initialize(params)
        @params = params.slice(:email, :name)
      end

      def call
        if valid?
          create_user
          AppMailer.signup_email(user).deliver_later
        end
      end

      private

      attr_reader :params, :user

      def create_user
        @user = ::User.create(params)
      end

      def name
        params[:name]
      end
    end
  end
end