class AdminMailer < ApplicationMailer
  default from: 'no-reply@tradeable.com'

  def send_trader_approval(trader)
    @trader = trader
    mail to: @trader.email, subject: 'Approval Request'
  end
end
