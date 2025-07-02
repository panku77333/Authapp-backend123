# app/controllers/auth_controller.rb
class AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :register]

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      render json: {
        token: token,
        user: user_response(user)
      }
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  def register
    user = User.new(user_params)

    if user.save
      token = JwtService.encode(user_id: user.id)
      render json: {
        token: token,
        user: user_response(user)
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def me
    render json: { user: user_response(current_user) }
  end

  private

  def user_params
    params.permit(:name, :email, :password, :role)
  end

  def user_response(user)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role
    }
  end
end
