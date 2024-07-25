# == Schema Information
#
# Table name: gists
#
#  id          :bigint           not null, primary key
#  question_id :bigint           not null
#  user_id     :bigint           not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :url, presence: true
end
