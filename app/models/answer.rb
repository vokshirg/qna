class Answer < ActiveRecord::Base
  belongs_to :question
  validates :body, :question_id, presence: true

  default_scope { order("created_at DESC") } 
end
