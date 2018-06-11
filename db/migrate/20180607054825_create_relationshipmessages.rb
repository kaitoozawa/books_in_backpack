class CreateRelationshipmessages < ActiveRecord::Migration[5.0]
  def change
    create_table :relationshipmessages do |t|
      t.references :user, foreign_key: true
      t.references :m_request, foreign_key: { to_table: :users }

      t.timestamps
      
      t.index [:user_id, :m_request_id], unique: true
    end
  end
end
