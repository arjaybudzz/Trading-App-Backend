class Api::AdminsController < ApplicationController
  before_action :setup_admin, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]
  wrap_parameters include: %i[username first_name last_name email password password_confirmation]

  def show
    traders = { include: [:traders] }
    render json: AdminSerializer.new(@admin, traders).serializable_hash
  end

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      render json: AdminSerializer.new(@admin).serializable_hash, status: :created
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  def update
    if @admin.update(admin_params)
      render json: AdminSerializer.new(@admin).serializable_hash, status: :ok
    else
      render json: @admin.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @admin.destroy
    head 204
  end

  private

  def setup_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:username, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def check_owner
    head :forbidden unless @admin.id == current_admin&.id
  end
end
