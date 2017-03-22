require 'spec_helper'

describe Services::Invitation::Accept do

  let!(:invitation) { Factories.create_invitation }
  let(:inviter)     { invitation.inviter }

  def action
    described_class.new(invitation).call
  end

  # would actually contain the code from invitations_controller_spec
end