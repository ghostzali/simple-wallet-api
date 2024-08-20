# frozen_string_literal: true

module JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded) unless revoked?(token)
  rescue
    nil
  end

  def self.revoked?(token)
    !Session.active.find_by(token: token).present?
  end
end
