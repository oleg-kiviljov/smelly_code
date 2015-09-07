class ChangeLanguageIdToLexerId < ActiveRecord::Migration
  def change
    rename_column :snippets, :language_id, :lexer_id
  end
end
