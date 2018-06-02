class ChangeColumnNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :mylocation_id, false
  end
end