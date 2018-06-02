class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :image
      t.string :name
      t.string :nationality
      t.string :gender
      t.integer :age
      t.string :description

      t.timestamps
    end
  end
end
