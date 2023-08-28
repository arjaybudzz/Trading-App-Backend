# Preview all emails at http://localhost:3000/rails/mailers/trader_mailer
class TraderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/trader_mailer/pending_admin_approval

  def pending_admin_approval
    @trader = Trader.last
    TraderMailer.pending_admin_approval(@trader)
  end

  # Preview this email at http://localhost:3000/rails/mailers/trader_mailer/account_submission_notification

  def account_submission_notification
    @trader = Trader.last
    TraderMailer.account_submission_notification(@trader)
  end
end
