class CreateMylocations < ActiveRecord::Migration[5.0]
  def change
    create_table :mylocations do |t|
      t.references :country, foreign_key: true
      t.string :city

      t.timestamps
    end
  end
end
