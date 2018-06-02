class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :request, foreign_key: { to_table: :users }

      t.timestamps
      
      t.index [:user_id, :request_id], unique: true
    end
  end
end
