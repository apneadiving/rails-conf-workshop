class InvitationsController < ApplicationController

  def accept
    Wf.new
      .chain(invitee: :invitee) do
        Services::Invitation::Accept.new(invitation)
      end
      .chain do |outflow|
        render json: { user: outflow.invitee }
      end
      .on_dam do |error_pool|
        render json: { errors: error_pool.full_messages }, status: 422
      end
  end

  private

  def invitation
    @invitation ||= Invitation.find(params[:id])
  end
end