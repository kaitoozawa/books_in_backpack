class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.references :user, foreign_key: true
      t.string :image
      t.string :title
      t.string :author
      t.string :language
      t.integer :page
      t.string :description

      t.timestamps
    end
  end
end
