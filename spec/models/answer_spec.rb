require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question_ra) { create :question_with_right_answers }
  let(:answer) { create :answer }
  let(:ra) { create :answer, question: answer.question, right_answer: true }

  describe "ActiveRecord associations" do
    it { should belong_to :question }
    it { should belong_to :user }
    it { should have_db_index(:question_id) }
  end

  describe "ActiveModel validations" do
    it { should validate_presence_of :question_id }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :body }
  end

  describe "#is_right_answer" do
    before do
      question_ra.answers.first.is_right_answer(question_ra.user)
      question_ra.answers.reload
      question_ra.reload
    end

    it "validates that right answer changes" do
      expect(ra.right_answer).to eq true
      expect(answer.right_answer).to eq false
      answer.is_right_answer(answer.question.user)
      ra.reload
      expect(answer.right_answer).to eq true
      expect(ra.right_answer).to eq false
    end

    it "only one right answer" do
      expect(question_ra.answers.where(right_answer: true).count).to eq 1
    end

    it "right answer is first" do
      expect(question_ra.answers.first.right_answer).to eq true
      expect(question_ra.answers.last.right_answer).to eq false
    end

    it "right answer of answer's question_ra is equal answer " do
      expect(question_ra.right_answer).to eq(question_ra.answers.first)
    end
  end

  describe "#not_right_answer" do
    before { ra.not_right_answer(ra.question.user) }
    it { expect(ra.right_answer).to eq false }

    it "answer's question havn't right answers" do
      expect(ra.question.right_answer).to eq(nil)
    end
  end
end
