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

  scope :easy, -> { where(level: [0, 1]) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  scope :by_category_title, ->(category_title) {
    joins(:category).where(categories: { title: category_title })
  }

  def self.titles_by_category(category_title)
    by_category_title(category_title).order(title: :desc).pluck(:title)
  end
end
# Test model
