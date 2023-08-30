class Api::TransactionsController < ApplicationController
  before_action :setup_transaction, only: %i[show destroy]
  before_action :check_current_ticker, only: %i[create]
  before_action :check_ticker, only: %i[destroy]

  def index
    @transaction = Transaction.all
    render json: TransactionSerializer.new(@transaction).serializable_hash
  end

  def show
    ticker = { included: [:ticker] }
    render json: TransactionSerializer.new(@transaction, ticker).serializable_hash
  end

  def create
    @transaction = current_ticker.transactions.build(transaction_params)

    if @transaction.save
      update_trader_balance
      render json: TransactionSerializer.new(@transaction).serializable_hash, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    head 204
  end

  private

  def setup_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:stock, :profit, :percent, :action)
  end

  def update_trader_balance
    case @transaction.action
    when 'buy'
      StockComputingApi.buy_profit(current_ticker, @transaction, current_ticker.trader)
    when 'sell'
      StockComputingApi.sell_profit(current_ticker, @transaction, current_ticker.trader)
    end
  end

  def check_ticker
    head :forbidden unless @transaction.ticker_id == current_ticker&.id
  end
end
