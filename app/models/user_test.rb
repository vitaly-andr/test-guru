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

  enum status: {
    in_progress: 'in_progress',
    completed: 'completed'
  }

  validates :status, presence: true, inclusion: { in: statuses.keys }
end

