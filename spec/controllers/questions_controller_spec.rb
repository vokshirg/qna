require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create :question }

  describe "GET #index" do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, id: question }

    it 'assign the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assign new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it "assigns a new Attachment for answer to @attachment" do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    sign_in_user
    before { get :new }

    it "assigns a new Question to @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "assigns a new Attachment to @attachment" do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do
    context "user is owner of question" do
      before { sign_in(question.user) }
      before { get :edit, id: question }

      it 'assign the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it "renders edit view" do
        expect(response).to render_template :edit
      end
    end

    context "user is not owner of question" do
      sign_in_user
      before { get :edit, id: question }

      it "renders edit view" do
        expect(response).to redirect_to question_path(question)
      end
    end

  end

  describe "POST #create" do
    sign_in_user
    context "with valid attributes" do
      it "save the new question in the database" do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'connects with author' do
        post :create, question: attributes_for(:question)
        expect(assigns(:question).user).to eq @user
      end

      it "redirect to show view" do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns :question)
      end
    end
    context "with invalid attributes" do
      it "doesn't save the new question in the database" do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end
      it "re-render new view" do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    sign_in_user
    context "with valid attributes" do
      it 'assign the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it "changes question attrs" do
        patch :update, id: question, question: { title: 'new title', body: 'new body' }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it "redirect to the updated question" do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end
    context "with invalid attributes" do
      before { patch :update, id: question, question: { title: 'new title', body: nil } }
      it "doesn't changes question attrs" do
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'Text of question body'
      end

      it "re-render edit view" do
        expect(response).to render_template :edit
      end
    end
  end
  describe "DELETE #destroy" do

    context "when user is owner of question" do
      before { sign_in(question.user) }
      before { question }
      it "delete question" do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end
      it "redirect to index view" do
        expect(delete :destroy, id: question).to redirect_to questions_path
      end
    end

    context "when user is not owner of question" do
      sign_in_user
      before { question }
      it "delete question" do
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end
      it "redirect to index view" do
        expect(delete :destroy, id: question).to redirect_to question_path(question)
      end
    end
  end
end
