class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  has_many :attachments, as: :attachable

  validates :body, :title, :user_id,  presence: true

  accepts_nested_attributes_for :attachments

  def right_answer
    self.answers.where("right_answer = ? ", true).first
  end
end
