# == Schema Information
#
# Table name: badges
#
#  id          :bigint           not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  rule        :integer          default("complete_category"), not null
#  rule_value  :string
#  description :text

class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  enum rule: {
    complete_category: 0,
    first_try: 1,
    complete_level: 2,
    all_tests_passed: 3
  }

  validates :title, presence: true
  validates :rule, presence: true
  validates :rule_value, presence: true, if: :rule_requires_value?

  has_one_attached :image


  private

  def rule_requires_value?
    complete_category? || complete_level?
  end


end
