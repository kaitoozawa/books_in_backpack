class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :recipient, foreign_key: { to_table:  :users }
      t.string :content

      t.timestamps
    end
  end
end
