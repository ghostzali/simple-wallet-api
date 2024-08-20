# frozen_string_literal: true

module CurrentUser
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded
    render json: { error: 'Not authenticated'}, status: :unauthorized unless @current_user
  end
end
