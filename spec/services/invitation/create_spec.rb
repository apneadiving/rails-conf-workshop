require 'spec_helper'

describe Services::Invitation::Create do

  let(:inviter)    { Factories.create_user }
  let(:invitee_email) { 'invitee@foo.com' }
  let(:service)    { described_class.new(inviter: inviter, email: invitee_email) }

  it 'does create invitation' do
    expect { service.call }.to change { User.count }.by 1
  end

  it 'links invitation to inviter' do
    service.call
    expect(service.invitation.inviter).to be_present
  end

  it 'sends invitation email' do
    expect(AppMailer).to receive_message_chain(:invitation_email, :deliver_later)

    service.call
  end
end