class InvitationsController < ApplicationController

  def accept
    Wf.new
      .chain(user: :user) { Services::Invitation::Accept.new(invitation) }
      .chain do |outflow|
        render json: { user: outflow.user }
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