class AddPublishedToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :published, :boolean
  end
end
