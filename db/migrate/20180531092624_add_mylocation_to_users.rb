class AddMylocationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :mylocation, foreign_key: true
  end
end
