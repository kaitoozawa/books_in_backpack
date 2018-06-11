class RenameMRelationshipToRelationshipmessage < ActiveRecord::Migration[5.0]
  def change
    rename_table :m_relationships, :relationshipmessages
  end
end
