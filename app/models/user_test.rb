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
class UserTest < ApplicationRecord
  belongs_to :user
  belongs_to :test

  validates :status, presence: true, inclusion: { in: %w[in_progress completed] }
end
