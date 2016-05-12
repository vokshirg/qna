class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_one :answer, as: :right_answer
  alias_attribute :right_answer, :answer
  belongs_to :user

  validates :body, :title, :user_id,  presence: true
end
