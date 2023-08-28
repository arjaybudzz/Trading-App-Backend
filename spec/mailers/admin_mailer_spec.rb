require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe 'send_trader_approval' do
    let(:admin_sample) { create(:admin) }
    let(:trader_sample) { create(:trader) }
    let(:mail) { AdminMailer.send_trader_approval(trader_sample) }

    before do
      admin_sample.traders << trader_sample
    end

    it { expect('Approval Request').to eq(mail.subject) }
    it { expect([admin_sample.traders.first.email]).to eq(mail.to) }
    it { expect(['no-reply@tradeable.com']).to eq(mail.from) }
    it { expect(/Congratulations! Your account has been approved. Happy Trading!/).to match(mail.body.parts[0].body.raw_source) }
  end

end
