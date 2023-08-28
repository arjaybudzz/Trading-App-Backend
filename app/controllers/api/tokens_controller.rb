class Api::TokensController < ApplicationController

  def create
    admin = Admin.find_by_email(admin_params[:email])

    if admin&.authenticate(admin_params[:password])
      render json: {
        token: JsonWebToken.encode(admin_id: admin.id),
        email: admin.email,
        username: admin.username,
        id: admin.id
      }
    else
      head :unauthorized
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password)
  end
end
