module Services
  module Invitation
    class Accept

      attr_reader :invitation, :issues

      class ServiceError < StandardError; end
      include ActiveModel::Validations

      def initialize(invitation)
        @invitation = invitation
      end

      def call
        if invitation.accepted?
          errors.add :status, 'Invitation already accepted'
          @issues = errors
        else
          ActiveRecord::Base.transaction do
            perform
            raise ServiceError unless success?
          end
        end
      rescue ServiceError
      end

      def user
        @create_service.user
      end

      def success?
        @issues.blank?
      end

      private

      def perform
        @create_service = ::Services::User::CreateFromInvitation.new(invitation)
        @create_service.call
        if @create_service.success?
          invitation.accept
          if invitation.save
            credit_service = Services::User::Credit.new(user: invitation.inviter, cents: REFERRER_FEE_IN_CENTS, source: invitation)
            credit_service.call
            unless credit_service.success?
              @issues = credit_service.issues
            end
          else
            @issues = invitation.errors
          end
        else
          @issues = @create_service.issues
        end
      end

      REFERRER_FEE_IN_CENTS = 500

      attr_reader :invitation
    end
  end
end