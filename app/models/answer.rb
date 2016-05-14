class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true

  default_scope { order("right_answer DESC").order("created_at DESC") }

  def reset_right_answers
    self.question.answers.where("right_answer = ?", true).update_all(right_answer: false)
  end
end
