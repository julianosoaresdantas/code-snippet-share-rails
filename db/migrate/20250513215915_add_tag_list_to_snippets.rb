class AddTagListToSnippets < ActiveRecord::Migration[8.0]
  def change
    add_column :snippets, :tag_list, :string
  end
end
