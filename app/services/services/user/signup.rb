module Services
  module User
    class Signup

      include Waterfall

      validates :name, presence: true

      delegate :name, to: :user

      def initialize(params)
        @params = params.slice(:email, :name)
      end

      def call
        when_falsy { valid? }
          .dam { errors }
        when_falsy { user.save }
          .dam { user.errors }
        chain do
          AppMailer.signup_email(user).deliver_later
        end
      end

      private

      attr_reader :params

      def user
        @user ||= ::User.new(params)
      end
    end
  end
end