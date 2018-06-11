class RenameTypeColumnToTrade1s < ActiveRecord::Migration[5.0]
  def change
    rename_column :trade1s, :type, :answer
  end
end
