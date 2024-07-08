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
  # has_many :user_tests
  # has_many :tests, through: :user_tests
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :authored_tests, class_name: 'Test', foreign_key: 'author_id', inverse_of: :author


  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def tests_by_level(level)
    user_tests.by_level(level).select('tests.*, user_tests.status')
  end
  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
# User model
