class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :body, :title, :user_id,  presence: true

  def right_answer
    self.answers.where("right_answer = ? ", true).first || false
  end
end
