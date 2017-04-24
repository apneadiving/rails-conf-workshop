class InvitationsController < ApplicationController

  def accept
    service = Services::Invitation::Accept.new(invitation)
    service.call
    if service.success?
      render json: { user: service.user }
    else
      render json: { errors: service.issues.full_messages }, status: 422
    end
  end

  private

  def invitation
    @invitation ||= Invitation.find(params[:id])
  end
end