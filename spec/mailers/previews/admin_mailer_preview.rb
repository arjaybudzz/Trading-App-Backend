# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer/send_trader_approval
  def send_trader_approval
    @trader = Trader.last
    AdminMailer.send_trader_approval(@trader)
  end
end
