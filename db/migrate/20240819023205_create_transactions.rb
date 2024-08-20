class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, null: false
      t.string :transaction_type, null: false
      t.integer :source_wallet_id
      t.integer :target_wallet_id

      t.timestamps
    end

    add_foreign_key :transactions, :wallets, column: :source_wallet_id
    add_foreign_key :transactions, :wallets, column: :target_wallet_id
  end
end
