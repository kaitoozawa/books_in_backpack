class AddMessageUserIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :message_user_id, :integer
  end
end
