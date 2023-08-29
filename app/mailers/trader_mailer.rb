class TraderMailer < ApplicationMailer
  default from: 'no-reply@tradeable.com'

  def pending_admin_approval(trader)
    @trader = trader
    @admin = @trader.admin

    mail to: @admin.email, subject: 'Approval Request'
  end

  def account_submission_notification(trader)
    @trader = trader

    mail to: [@trader.email], subject: 'Account Submitted'
  end
end
