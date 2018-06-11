class CreateTrade1s < ActiveRecord::Migration[5.0]
  def change
    create_table :trade1s do |t|
      t.references :user, foreign_key: true
      t.references :trader, foreign_key: { to_table: :users }
      t.string :type

      t.timestamps
      
      t.index [:user_id, :trader_id], unique: true
    end
  end
end
