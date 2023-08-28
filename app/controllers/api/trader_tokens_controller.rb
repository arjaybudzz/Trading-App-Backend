class Api::TraderTokensController < ApplicationController
  def create
    @trader = Trader.find_by_email(trader_permitted_params[:email])

    if @trader&.authenticate(trader_permitted_params[:password])
      render json: {
        trader_token: JsonWebToken.encode(trader_id: @trader.id),
        username: @trader.username,
        email: @trader.email,
        id: @trader.id
      }
    else
      head :unauthorized
    end
  end

  private

  def trader_permitted_params
    params.require(:trader).permit(:email, :password)
  end
end
