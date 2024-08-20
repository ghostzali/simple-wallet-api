class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.decimal :balance, default: 0, null: false
      t.string :entity_type
      t.integer :entity_id

      t.timestamps
    end

    add_index :wallets, [:entity_type, :entity_id]
  end
end
