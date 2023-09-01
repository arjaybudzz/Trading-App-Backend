class Api::TickerTokensController < ApplicationController
  def create
    @ticker = Ticker.find_by_symbol(ticker_token_params[:symbol])

    if @ticker
      render json: {
        ticker_token: JsonWebToken.encode(ticker_id: @ticker.id),
        symbol: @ticker.symbol,
        last_price: @ticker.last_price,
        latest_price: @ticker.latest_price
      }
    else
      head :unauthorized
    end
  end

  private

  def ticker_token_params
    params.require(:ticker).permit(:symbol)
  end
end
