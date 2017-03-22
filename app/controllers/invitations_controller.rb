class InvitationsController < ApplicationController

  def accept
    if invitation.accepted?
      render json: { errors: ['Invitation already accepted'] }, status: 422
    else
      user = User.create_from_invitation(invitation)
      invitation.accepted = true
      invitation.save
      render json: { user: user }
    end
  end

  private

  def invitation
    @invitation ||= Invitation.find(params[:id])
  end
end