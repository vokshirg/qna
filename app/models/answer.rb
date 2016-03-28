class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true

  default_scope { order("created_at DESC") }
end
