class Category < ApplicationRecord
  has_many :tests

  validates :title, presence: true
end
