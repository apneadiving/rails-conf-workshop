require 'spec_helper'

describe InvitationsController, type: :controller do

  let!(:invitation) { Factories.create_invitation }
  let(:inviter)     { invitation.inviter }

  def action
    get :accept, params: { id: invitation.id }
  end

  it 'creates invitee' do
    expect(AppMailer).to receive_message_chain(:welcome_email, :deliver_later)

    expect { action }.to change { User.count }.by(1)

    invitation.reload

    expect(invitation.invitee).to be_present
  end

  it 'marks invitation as accepted' do
    expect { action }.to change { invitation.reload.accepted? }.from(false).to(true)
  end

  it 'pays inviter' do
    expect(AppMailer).to receive_message_chain(:notify_payment, :deliver_later)

    expect { action }.to change { inviter.affilation_earnings_cents }.by(500)
  end

  xcontext 'errors happen' do

    before do
      expect(CreditTransaction).to receive(:create) { raise ActiveRecord::ActiveRecordError }
    end

    it 'must not create a user' do
      initial_user_count = User.count

      expect { action }.to raise_error(ActiveRecord::ActiveRecordError)

      expect(User.count).to eq initial_user_count
    end

    it 'must not accept invitation' do
      expect { action }.to raise_error(ActiveRecord::ActiveRecordError)

      invitation.reload

      expect(invitation.accepted?).to be false
    end
  end
end