class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :private, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
