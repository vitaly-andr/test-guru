class AddForeignKeyToTests < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :tests, :users, column: :author_id
  end
end
