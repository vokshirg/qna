require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create :question }
  let(:answer) { create :answer, question: question }

  describe "GET #new" do
    before { sign_in(answer.user) }
    before { get :new, question_id: question.id }

    it "assigns a new Answer to @answer" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    sign_in_user
    context "with valid attributes" do
      it "save the new answer in the database" do
        expect { post :create, answer: attributes_for(:answer), question_id: question.id, format: :js }.to change(question.answers, :count).by(1)
      end

      it "re-render create.js template" do
        post :create, answer: attributes_for(:answer), question_id: question.id, format: :js
        expect(response).to render_template :create
      end
    end

    context "with invalid attributes" do
      it "doesn't save the new answer in the database" do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question.id, format: :js }.to_not change(Answer, :count)
      end

      it "re-render new view" do
        post :create, answer: attributes_for(:invalid_answer), question_id: question.id, format: :js
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    context "when user is owner of answer" do
      before { sign_in(answer.user) }
      before { get :edit, id: answer, question_id: question.id }

      it 'assign the requested answer to @answer' do
        expect(assigns(:answer)).to eq answer
      end

      it "renders edit view" do
        expect(response).to render_template :edit
      end
    end

    context "when user is not owner of answer" do
      sign_in_user
      before { get :edit, id: answer, question_id: question.id }

      it "redirect to index view" do
        expect(get :edit, id: answer).to redirect_to question_path(answer.question)
      end
    end
  end

  describe "PATCH #update" do
    context "when user is owner of answer" do
      before { sign_in(answer.user) }

      context "with valid attributes" do
        it 'assign the requested answer to @answer' do
          patch :update, id: answer, answer: attributes_for(:answer), format: :js
          expect(assigns(:answer)).to eq answer
        end

        it "changes answer attrs" do
          patch :update, id: answer, answer: { body: 'new body' }, format: :js
          answer.reload
          expect(answer.body).to eq 'new body'
        end

        it "render :update" do
          expect(patch :update, id: answer, answer: attributes_for(:answer), format: :js).to render_template :update
        end
      end

      context "with invalid attributes" do
        before { patch :update, id: answer, answer: { body: nil }, format: :js }

        it "doesn't changes answer attrs" do
          answer.reload
          expect(answer.body).to eq 'Text of answer body'
        end

        it "re-render edit view" do
          expect(response).to render_template :edit
        end
      end
    end

    context "when user is not owner of answer" do
      sign_in_user

      it "not changes answer attrs" do
        patch :update, id: answer, answer: { body: 'new body' }
        answer.reload
        expect(answer.body).to_not eq 'new body'
      end

      it "redirect to index view" do
        expect(patch :update, id: answer, answer: { body: 'new body' }).to redirect_to question_path(answer.question)
      end
    end
  end

  describe "DELETE #destroy" do
    before { answer }

    context "when user is owner of answer" do
      before { sign_in(answer.user) }
      it "delete answer" do
        expect { delete :destroy, id: answer, format: :js }.to change(question.answers, :count).by(-1)
      end
      it "redirect to index view" do
        expect(delete :destroy, id: answer, format: :js).to render_template :destroy
      end
    end

    context "when user is not owner of answer" do
      sign_in_user

      it "delete answer" do
        expect { delete :destroy, id: answer, format: :js }.to_not change(Answer, :count)
      end

      it "redirect to index view" do
        expect(delete :destroy, id: answer, format: :js).to redirect_to question_path(answer.question)
      end
    end
  end

  describe "PATCH #right_answer" do
    before { answer }

    context "author of question" do
      before { sign_in(answer.question.user) }
      before { patch :right_answer, id: answer, format: :js }

      it 'assign the requested answer to @answer' do
        expect(assigns(:answer)).to eq answer
      end

      it 'assign the right_answer to question' do
        expect(assigns(:answer).question.right_answer).to eq answer
      end

      it 'just one right answer' do
        expect(assigns(:answer).question.answers.where("right_answer = ?", true).count).to eq 1
      end

      it 'set right answer flag to true' do
        expect(assigns(:answer).right_answer).to eq true
      end

      it "render right_answer.js template" do
        expect( patch :right_answer, id: answer, format: :js ).to render_template :right_answer
      end
    end

    context "not author of question" do
      sign_in_user
      before { patch :not_right_answer, id: answer, format: :js }

      it "render 403" do
        expect(response.status).to eq(403)
      end
    end
  end


  describe "PATCH #not_right_answer" do
    before { answer }

    context "author of question" do
      before { sign_in(answer.question.user) }
      before { patch :not_right_answer, id: answer, format: :js }

      it 'assign the requested answer to @answer' do
        expect(assigns(:answer)).to eq answer
      end

      it 'no one right answer' do
        expect(assigns(:answer).question.answers.where("right_answer = ?", true).count).to eq 0
      end

      it 'set right answer flag to false' do
        expect(assigns(:answer).right_answer).to eq false
      end

      it "render right_answer.js template" do
        expect(response).to render_template :right_answer
      end
    end

    context "not author of question" do
      sign_in_user
      before { patch :not_right_answer, id: answer, format: :js }

      it "render 403" do
        expect(response.status).to eq(403)
      end
    end
  end
end
