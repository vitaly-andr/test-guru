# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  test_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  belongs_to :test
  has_many :answers
  has_many :gists, dependent: :destroy


  validates :body, presence: true
  validate :validate_answers_count

  private

  def validate_answers_count
#    errors.add(:base, 'should have at least one answer') if answers.size < 1
    errors.add(:base, 'should have at most four answers') if answers.size > 4
  end
end
# Question model
