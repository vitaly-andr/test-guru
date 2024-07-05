# == Schema Information
#
# Table name: tests
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  level       :integer          default(0)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :integer          not null
#
class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :user_tests
  has_many :users, through: :user_tests
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', inverse_of: :authored_tests


  validates :title, presence: true
  validates :author_id, presence: true

  scope :easy, -> { where(level: [0, 1]) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  def self.titles_by_category(category_title)
    joins(:category).where(categories: { title: category_title }).order(title: :desc).pluck(:title)
  end
end
# Test model
