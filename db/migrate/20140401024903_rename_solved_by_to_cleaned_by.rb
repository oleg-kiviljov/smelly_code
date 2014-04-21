class RenameSolvedByToCleanedBy < ActiveRecord::Migration
  def change
    rename_column :snippets, :solved_by, :cleaned_by
  end
end
