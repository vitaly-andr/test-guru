class UserTest < ApplicationRecord
  belongs_to :user
  belongs_to :test

  validates :status, presence: true, inclusion: { in: %w[in_progress completed] }
end
