# == Schema Information
#
# Table name: user_badges
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  badge_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class UserBadgeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
