require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to(:user) }

  it { should validate_presence_of :user_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  let(:question) { create :question }
  let!(:ra) { create :answer, question: question, right_answer: true }
  let!(:answer) { create :answer, question: question, right_answer: false }

  it "right answer of answer's question is equal answer " do
    expect(question.right_answer).to eq(ra)
  end

end
