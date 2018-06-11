class RenameTypeColumnToTrade2s < ActiveRecord::Migration[5.0]
  def change
    rename_column :trade2s, :type, :answer
  end
end
