class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true
      t.datetime :revoked_at

      t.timestamps
    end

    add_index :sessions, :token, unique: true
  end
end
