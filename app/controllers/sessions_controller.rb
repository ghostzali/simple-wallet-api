class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      Session.create!(token: token, user: user)
      render json: { message: 'Logged in successfully', user: user.slice(:id, :name, :email), token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    token = request.headers['Authorization']&.split(' ')&.last
    session = Session.find_by(token: token)
    if session
      session.update(revoked_at: Time.current)
      render json: { message: 'Logged out successfully' }, status: :ok
    else
      render json: { error: 'Invalid token'}, status: :unauthorized
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
