class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  validates :body, :question_id, :user_id, presence: true

  default_scope { order("right_answer DESC").order("created_at DESC") }

  def is_right_answer(current_user)
    transaction do
      if current_user.is_author?(self.question)
        self.question.answers.where("right_answer = ?", true).update_all("right_answer = false")
        self.reload.update(right_answer: true)
      end
    end
  end

  def not_right_answer(current_user)
    if current_user.is_author?(self.question)
      self.reload.update(right_answer: false)
    end
  end
end
