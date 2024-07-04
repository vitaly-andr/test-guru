class AddAuthorIdToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :author_id, :integer
  end
end
