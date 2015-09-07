class CreateLexers < ActiveRecord::Migration
  def change
    create_table :lexers do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
