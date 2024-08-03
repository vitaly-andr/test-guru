class AddRuleAndRuleValueToBadges < ActiveRecord::Migration[7.1]
  def change
    add_column :badges, :rule, :integer, null: false, default: 0
    add_column :badges, :rule_value, :string
  end
end
