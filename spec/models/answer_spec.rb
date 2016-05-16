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
    let(:question_ra) { create :question_with_right_answers }
    let(:ra) { create :answer, right_answer: true }

    context "responds to its methods" do
      it { expect(ra).to respond_to(:is_right_answer) }
      it { expect(ra).to respond_to(:not_right_answer) }
    end

    context "executes methods correctly" do
      context "#is_right_answer" do
        before {
          @qra = question_ra
          @qra.answers.first.is_right_answer
          @qra.answers.reload
          @qra.reload
          # raise @qra.answers.first.inspect
        }
        it { expect(question_ra.answers.first.right_answer).to eq true }
        it { expect(question_ra.answers.last.right_answer).to eq false }

        it "right answer of answer's question_ra is equal answer " do
          # raise question_ra.inspect
          expect(question_ra.right_answer).to eq(question_ra.answers.first)
        end
      end

      context "#not_right_answer" do
        before { ra.not_right_answer }
        it { expect(ra.right_answer).to eq false }

        it "answer's question havn't right answers" do
          expect(ra.question.right_answer).to eq(nil)
        end
      end
    end
  end

end
