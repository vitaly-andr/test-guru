class AddDescriptionToBadges < ActiveRecord::Migration[7.1]
  def change
    add_column :badges, :description, :text
  end
end
