require 'spec_helper'

describe Services::User::Signup do

  let(:service) { described_class.new(params) }

  context 'valid' do
    let(:params) { { name: 'john doe', email: 'john@doe.com' } }
    it 'does create user' do
      expect { service.call }.to change { User.count }.by 1
    end

    it 'sends signup_email' do
      expect(AppMailer).to receive_message_chain(:signup_email, :deliver_later)

      service.call
    end
  end

  context 'invalid' do
    let(:params) { { email: 'john@doe.com' } }
    it 'doesnt create user' do
      expect { service.call }.to_not change { User.count }
    end
  end
end