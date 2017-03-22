module Services
  module User
    class Credit

      # include ActiveModel::Validations

      def initialize(user:, cents:, source:)
        @user, @cents, @source = user, cents, source
      end

      def call
        # goal:
        # this object must take care of logic concerning payment
      end

      private

      attr_reader :user, :cents, :source
    end
  end
end