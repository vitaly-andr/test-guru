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

  scope :correct, -> { where(correct: true) }
end
# Answer model
