require 'spec_helper'

describe Services::User::CreateFromInvitation do

  let(:service)     { described_class.new(invitation) }
  let!(:invitation) { Factories.create_invitation }

  it 'does create user' do
    expect { service.call }.to change { User.count }.by 1
  end

  it 'links invitation to user' do
    service.call
    expect(invitation.invitee).to be_present
  end

  it 'sends welcome_email' do
    expect(AppMailer).to receive_message_chain(:welcome_email, :deliver_later)

    service.call
  end
end