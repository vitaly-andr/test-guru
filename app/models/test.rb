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
#
class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
  has_many :user_tests
  has_many :users, through: :user_tests

  validates :title, presence: true

  def self.titles_by_category(category_title)
    joins(:category).where(categories: { title: category_title }).order(title: :desc).pluck(:title)
  end
end
# Test model
