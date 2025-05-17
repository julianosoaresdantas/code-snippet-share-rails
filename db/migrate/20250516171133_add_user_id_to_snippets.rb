class AddUserIdToSnippets < ActiveRecord::Migration[7.1] # Or your Rails version
  def change
    # This migration was attempting to add the user_id column,
    # but it seems the column already exists.
    # If the association is set up in the models, we can comment this out.
    # add_reference :snippets, :user, foreign_key: true, null: false
  end
end
