module Services
  module User
    class Signup

      # include ActiveModel::Validations

      def initialize(params)
        @params = params.slice(:email, :name)
      end

      def call
        # goal:
        # - edit after_create from user model
        # - remove name validation from user model but add it here
        ::User.create(params)
      end

      private

      attr_reader :params
    end
  end
end