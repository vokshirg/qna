class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true

  default_scope { order("right_answer DESC").order("created_at DESC") }

  def is_right_answer
    self.question.answers.where("right_answer = ?", true).update_all("right_answer = false")
    self.reload.update(right_answer: true)
  end

  def not_right_answer
    self.reload.update(right_answer: false)
  end
end
