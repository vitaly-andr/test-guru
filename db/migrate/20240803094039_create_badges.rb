class CreateBadges < ActiveRecord::Migration[7.1]
  def change
    create_table :badges do |t|
      t.string :title
      t.text :description
      t.integer :rule, default: 0, null: false
      t.string :rule_value

      t.timestamps
    end
  end
end
