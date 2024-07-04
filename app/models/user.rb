# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :user_tests
  has_many :tests, through: :user_tests

  validates :name, presence: true
  validates :email, presence: true

  def tests_by_level(level)
    user_tests.joins(:test).where(tests: { level: level }).select('tests.*, user_tests.status')
  end
end
# User model
