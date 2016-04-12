class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wiki, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
