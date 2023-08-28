class Api::TickersController < ApplicationController
  before_action :setup_ticker, only: %i[show update destroy]
  before_action :check_trader_login, only: [:create]
  before_action :check_trader, only: %i[update destroy]

  def index
    @ticker = Ticker.all
    render json: TickerSerializer.new(@ticker).serializable_hash
  end

  def show
    transactions = { include: [:transactions] }
    render json: TickerSerializer.new(@ticker, transactions).serializable_hash
  end

  def create
    @ticker = current_trader.tickers.build(ticker_params)
    if @ticker.save
      render json: TickerSerializer.new(@ticker).serializable_hash, status: :created
    else
      render json: @ticker.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ticker.update(ticker_params)
      render json: TickerSerializer.new(@ticker).serializable_hash, status: :ok
    else
      render json: @ticker, status: :unprocessable_entity
    end
  end

  def destroy
    @ticker.destroy
    head 204
  end

  private

  def setup_ticker
    @ticker = Ticker.find(params[:id])
  end

  def ticker_params
    params.require(:ticker).permit(:symbol, :last_price, :time_stamp, :volume, :latest_price, :share)
  end

  def check_trader
    head :forbidden unless @ticker.trader_id == current_trader&.id
  end
end
