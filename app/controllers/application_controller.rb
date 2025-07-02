# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    return render json: { error: 'No token provided' }, status: :unauthorized unless header

    token = header.split(' ').last
    decoded = JwtService.decode(token)

    if decoded
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :unauthorized
  end

  def current_user
    @current_user
  end

  def admin_required
    render json: { error: 'Admin access required' }, status: :forbidden unless current_user&.role == 'admin'
  end
end
