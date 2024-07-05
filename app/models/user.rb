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
  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id', inverse_of: :author


  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  scope :tests_by_level, ->(user, level) {
    joins(:user_tests).merge(UserTest.by_level(level)).where(user_tests: { user_id: user.id }).select('tests.*, user_tests.status')
  }
end
# User model
