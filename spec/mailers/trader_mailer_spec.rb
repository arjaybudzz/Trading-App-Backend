require "rails_helper"

RSpec.describe TraderMailer, type: :mailer do

  setup do
    @trader_sample = create(:trader)
    @mail_to_admin = TraderMailer.pending_admin_approval(@trader_sample)
    @mail_to_trader = TraderMailer.account_submission_notification(@trader_sample)
  end

  describe 'pending_admin_approval' do

    it { expect('Approval Request').to eq(@mail_to_admin.subject) }

    it { expect([@trader_sample.admin.email]).to eq(@mail_to_admin.to) }

    it { expect(['no-reply@tradeable.com']).to eq(@mail_to_admin.from) }

    it { expect(/A new account is requesting for approval./).to match(@mail_to_admin.body.parts[0].body.raw_source) }
  end

  describe 'account_submission_notification' do

    it { expect('Account Submitted').to eq(@mail_to_trader.subject) }

    it { expect([@trader_sample.email]).to eq(@mail_to_trader.to) }

    it { expect(['no-reply@tradeable.com']).to eq(@mail_to_trader.from) }

    it { expect(/Your account registration has been submitted to admin for approval./).to match(@mail_to_trader.body.parts[0].body.raw_source) }

  end
end
