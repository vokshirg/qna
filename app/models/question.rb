class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  validates :body, :title,  presence: true
end
