class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true
  validate :validate_transaction

  after_create :update_wallet_balances

  private

  def validate_transaction
    if transaction_type == 'credit' && source_wallet.present?
      errors.add(:source_wallet, "must be nil for credit transactions")
    elsif transaction_type == 'debit' && target_wallet.present?
      errors.add(:target_wallet, "must be nil for debit transactions")
    elsif source_wallet == target_wallet
      errors.add(:base, "Source and target wallets can't be the same")
    end
  end

  def update_wallet_balances
    source_wallet&.calculate_balance
    target_wallet&.calculate_balance
  end
end
