# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text             not null
#  correct     :boolean          default(FALSE)
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_max_answers

  scope :correct, -> { where(correct: true) }

  private

  def validate_max_answers
    if question.answers.count >= 4
      errors.add(:question, "can't have more than 4 answers")
    end
  end
end
# Answer model
