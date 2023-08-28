class Api::TradersController < ApplicationController
  before_action :setup_trader, only: %i[show update destroy]
  before_action :check_login, only: %i[create]
  before_action :check_owner, only: %i[update destroy]
  before_action :check_approval, only: %i[update]
  wrap_parameters include: %i[username first_name last_name email country password password_confirmation balance approved]

  def index
    @trader = Trader.all
    render json: TraderSerializer.new(@trader).serializable_hash
  end

  def show
    tickers = { include: [:tickers] }
    render json: TraderSerializer.new(@trader, tickers).serializable_hash
  end

  def create
    @trader = current_admin.traders.build(registration_permitted_params)

    if @trader.save
      send_email_to_admin_and_trader(@trader)
      render json: TraderSerializer.new(@trader).serializable_hash, status: :created
    else
      render json: @trader.errors, status: :unprocessable_entity
    end
  end

  def update
    if @trader.update(trader_permitted_params)
      render json: TraderSerializer.new(@trader).serializable_hash, status: :ok
    else
      render json: @trader.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @trader.destroy
    head 204
  end

  private

  def setup_trader
    @trader = Trader.find(params[:id])
  end

  def trader_permitted_params
    params.require(:trader).permit(:username, :first_name, :last_name, :email, :country, :password, :password_confirmation, :balance, :approved)
  end

  def registration_permitted_params
    params.require(:trader).permit(:username, :first_name, :last_name, :email, :country, :password, :password_confirmation)
  end

  def check_owner
    head :forbidden unless @trader.admin_id == current_admin&.id
  end

  def check_approval
    AdminMailer.send_trader_approval(@trader).deliver_now if @trader.approved == true
  end

  def send_email_to_admin_and_trader(trader)
    TraderMailer.account_submission_notification(trader).deliver_now
    TraderMailer.pending_admin_approval(trader).deliver_now
  end
end
