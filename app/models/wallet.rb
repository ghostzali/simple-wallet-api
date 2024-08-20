class Wallet < ApplicationRecord
  belongs_to :entity, polymorphic: true
  has_many :outgoing_transactions, class_name: 'Transaction', foreign_key: :source_wallet_id
  has_many :incoming_transactions, class_name: 'Transaction', foreign_key: :target_wallet_id

  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def calculate_balance
    credits = incoming_transactions.sum(:amount)
    debits = outgoing_transactions.sum(:amount)
    self.update(balance: credits - debits)
  end
end
