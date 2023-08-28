module Authenticable
  def current_admin
    return @current_admin if @current_admin

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_admin = Admin.find(decoded[:admin_id]) rescue ActiveRecord::RecordNotFound
  end

  def current_trader
    return @current_trader if @current_trader

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_trader = Trader.find(decoded[:trader_id]) rescue ActiveRecord::RecordNotFound
  end

  def current_ticker
    return @current_ticker if @current_ticker

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)

    @current_ticker = Ticker.find(decoded[:ticker_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_login
    head :forbidden unless current_admin
  end

  def check_trader_login
    head :forbidden unless current_trader
  end

  def check_current_ticker
    head :forbidden unless current_ticker
  end
end
