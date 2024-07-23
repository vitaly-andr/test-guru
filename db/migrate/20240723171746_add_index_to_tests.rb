class AddIndexToTests < ActiveRecord::Migration[7.1]
  def change
    add_index :tests, :title
    add_index :tests, :level
  end
end
