require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user
  let(:question) { create :question }
  let(:answer) { create :answer, question_id: question.id, user_id: @user.id }

  describe "GET #new" do
    before { get :new, question_id: question.id }

    it "assigns a new Answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "save the new answer in the database" do
        expect { post :create, answer: attributes_for(:answer, user_id: @user.id, question_id: question.id), question_id: question.id }.to change(question.answers, :count).by(1)
      end

      it "redirect to show view" do
        post :create, answer: attributes_for(:answer, user_id: @user.id, question_id: question.id), question_id: question.id
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new answer in the database" do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question.id }.to_not change(Answer, :count)
      end

      it "re-render new view" do
        post :create, answer: attributes_for(:invalid_answer), question_id: question.id
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before { get :edit, id: answer, question_id: question.id }

    it 'assign the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it "renders edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it 'assign the requested answer to @answer' do
        patch :update, id: answer, question_id: question.id, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end

      it "changes answer attrs" do
        patch :update, id: answer, question_id: question.id, answer: { body: 'new body' }
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it "redirect to the question of updated answer" do
        patch :update, id: answer, question_id: question.id, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context "with invalid attributes" do
      before { patch :update, id: answer, question_id: question.id, answer: { body: nil } }

      it "doesn't changes answer attrs" do
        answer.reload
        expect(answer.body).to eq 'Text of answer body'
      end

      it "re-render edit view" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before { answer }

    it "delete answer" do
      expect { delete :destroy, id: answer, question_id: question.id }.to change(question.answers, :count).by(-1)
    end

    it "redirect to index view" do
      expect(delete :destroy, id: answer, question_id: question.id).to redirect_to question_path(answer.question)
    end
  end
end
