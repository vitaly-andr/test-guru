class Feedback < ApplicationRecord
  validates :name, :email, :message, presence: true
end
