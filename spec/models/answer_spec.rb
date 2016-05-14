require 'rails_helper'

RSpec.describe Answer, type: :model do

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

  describe "public instance methods" do
    let(:question) { create :question }
    let!(:answers) { create_list :answer_sequence, 3, right_answer: true, question: question }

    context "responds to its methods" do
      it { expect(answers.first).to respond_to(:reset_right_answers) }
    end

    context "executes methods correctly" do
      context "#reset_right_answers" do
        it "answer's question havn't right answers" do
          # expect(answers.first.question.right_answer).to eq(answers.last)
          answers.first.reset_right_answers
          expect(answers.first.question.right_answer).to eq(false)
        end

      end
    end
  end

end
