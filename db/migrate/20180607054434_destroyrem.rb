class Destroyrem < ActiveRecord::Migration[5.0]
  def change
    drop_table :m_relationships
  end
end
