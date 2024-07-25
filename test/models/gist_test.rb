# == Schema Information
#
# Table name: gists
#
#  id          :bigint           not null, primary key
#  question_id :bigint           not null
#  user_id     :bigint           not null
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
