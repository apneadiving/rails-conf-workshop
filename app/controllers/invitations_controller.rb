class InvitationsController < ApplicationController

  def accept
    if invitation.accepted?
      render json: { errors: ['Invitation already accepted'] }, status: 422
    else
      service = Services::Invitation::Accept.new(invitation)
      service.call
      render json: { user: service.user }
    end
  end

  private

  def invitation
    @invitation ||= Invitation.find(params[:id])
  end
end