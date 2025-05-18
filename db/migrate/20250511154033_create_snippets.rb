class CreateSnippets < ActiveRecord::Migration[7.1]
  def change
    create_table :snippets do |t|
      t.text :code
      t.string :language
      t.string :title
      t.text :description
      t.string :privacy, default: 'public' # Set a default privacy
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :snippets, :language
    add_index :snippets, :privacy
    add_index :snippets, :created_at
  end
end
