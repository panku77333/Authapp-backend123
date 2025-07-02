# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :admin_required

  def index
    users = User.all
    render json: {
      users: users.map { |user| user_response(user) }
    }
  end

  def show
    user = User.find(params[:id])
    render json: { user: user_response(user) }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: 'User deleted successfully' }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  private

  def user_response(user)
    {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
      created_at: user.created_at
    }
  end
end
