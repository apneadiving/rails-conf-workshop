require 'spec_helper'

describe Services::User::Credit do

  let(:service)     { described_class.new(user: user, cents: cents, source: invitation) }
  let!(:invitation) { Factories.create_invitation }
  let(:user)        { invitation.inviter }

  context 'valid' do
    let(:cents) { 200 }
    it 'sends email' do
      expect(AppMailer).to receive_message_chain(:notify_payment, :deliver_later)
      service.call
    end

    it 'creates transaction' do
      expect { service.call }.to change { user.affilation_earnings_cents }.by(cents)
    end
  end

  context 'invalid' do
    let(:cents) { -200 }
    it 'doesnt changed user balance' do
      expect { service.call }.to_not change { user.affilation_earnings_cents }
    end
  end
end
