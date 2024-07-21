# == Schema Information
#
# Table name: test_passages
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint           not null
#  test_id             :bigint           not null
#  current_question_id :bigint
#  correct_questions   :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require "test_helper"

class TestPassageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
