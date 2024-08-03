# == Schema Information
#
# Table name: badges
#
#  id          :bigint           not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rule        :integer          default("complete_category"), not null
#  rule_value  :string
#  description :text
#
require "test_helper"

class BadgeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
