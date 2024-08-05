# == Schema Information
#
# Table name: test_passages
#
#  id                  :bigint           not null, primary key
#  user_id             :integer          not null
#  test_id             :integer          not null
#  current_question_id :integer
#  correct_questions   :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  passed              :boolean          default(FALSE)
#
class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test, optional: true
  belongs_to :current_question, class_name: 'Question', optional: true
  before_create :set_question

  validate :test_has_questions, on: :create


  SUCCESS_CRITERIA = 85
  scope :passed, -> { where(passed: true) }

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    self.current_question = next_question

    save!
  end
  def current_question_number
    test.questions.order(:id).where('id <= ?', current_question.id).count
  end

  def total_questions
    test.questions.count
  end

  def success_percentage
    (correct_questions.to_f / test.questions.count) * 100
  end

  def success?
    success_percentage >= SUCCESS_CRITERIA
  end

  private

  def set_question
    if new_record?
      self.current_question = test.questions.first if test.present?
    else
      self.current_question = next_question
    end
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def test_has_questions
    errors.add(:test, 'must have questions to start the test') if test.questions.empty?
  end

end
