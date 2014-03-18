class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.text :smelly_body, null: false
      t.text :clean_body
      t.integer :user_id, null: false
      t.integer :language_id, null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
