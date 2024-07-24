# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint           not null, primary key
#  name       :string
#  email      :string
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Feedback < ApplicationRecord
  validates :name, :email, :message, presence: true
end
