# == Schema Information
#
# Table name: user_tests
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  test_id    :integer          not null
#  status     :string           default("in_progress"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class UserTestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
