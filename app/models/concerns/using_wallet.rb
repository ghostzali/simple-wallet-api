# frozen_string_literal: true

module UsingWallet
  extend ActiveSupport::Concern

  included do
    has_one :wallet, as: :entity, dependent: :destroy

    after_create :create_wallet_for_entity
  end

  private

  def create_wallet_for_entity
    Wallet.create(entity: self, balance: 0)
  end
end
