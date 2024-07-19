# == Schema Information
#
# Table name: gists
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  user_id     :integer          not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :url, presence: true
end
