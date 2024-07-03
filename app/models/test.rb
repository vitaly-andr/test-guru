class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  validates :title, presence: true
end
# Test model
