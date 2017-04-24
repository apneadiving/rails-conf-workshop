class InvitationsController < ApplicationController

  def accept
    if invitation.accepted?
      render json: { errors: ['Invitation already accepted'] }, status: 422
    else
      create_service = ::Services::User::CreateFromInvitation.new(invitation)
      create_service.call
      invitation.accepted = true
      invitation.save
      render json: { user: create_service.user }
    end
  end

  private

  def invitation
    @invitation ||= Invitation.find(params[:id])
  end
end