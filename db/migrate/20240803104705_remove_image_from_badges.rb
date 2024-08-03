class RemoveImageFromBadges < ActiveRecord::Migration[7.1]
  def change
    remove_column :badges, :image, :string
  end
end
