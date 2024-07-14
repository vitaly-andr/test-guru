# == Schema Information
#
# Table name: gists
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  user_id     :integer          not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class GistTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
