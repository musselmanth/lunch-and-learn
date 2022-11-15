class Api::V1::UsersController < ApplicationController
  def create
    new_user = User.new(user_params)
    if new_user.save
      render json: UserSerializer.new(new_user), status: :created
    else
      render json: ErrorSerializer.validation_errors(new_user.errors), status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end