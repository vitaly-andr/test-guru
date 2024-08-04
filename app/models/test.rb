# == Schema Information
#
# Table name: tests
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  level       :integer          default(0)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :integer          not null
#  published   :boolean
#  timer       :integer
#
class Test < ApplicationRecord
  belongs_to :category
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :nullify
  has_many :users, through: :test_passages
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', inverse_of: :authored_tests


  validates :title, presence: true, uniqueness: { scope: :level, message: "with this level already exists" }
  validates :level, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :author_id, presence: true
  validates :timer, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  validate :validate_published, if: :published?

  scope :easy, -> { where(level: [0, 1]) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  scope :by_category_title, ->(category_title) {
    joins(:category).where(categories: { title: category_title })
  }
  scope :published, -> { where(published: true) }

  def self.titles_by_category(category_title)
    by_category_title(category_title).order(title: :desc).pluck(:title)
  end
  private
  def validate_published
    validate_questions_presence
    validate_questions_content if errors[:published].blank?
  end

  def validate_questions_presence
    errors.add(:published, I18n.t('errors.messages.no_questions')) if questions.empty?
  end

  def validate_questions_content
    questions.each do |question|
      validate_answers_count(question)
      validate_correct_answers(question)
    end
  end
  def validate_answers_count(question)
    errors.add(:published, I18n.t('errors.messages.invalid_answers_count')) if question.answers.size != 4
  end

  def validate_correct_answers(question)
    errors.add(:published, I18n.t('errors.messages.no_correct_answers')) if question.answers.select(&:correct).empty?
  end
end
# Test model
