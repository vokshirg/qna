require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create :answer }
  describe "GET #index" do
    let(:answers) { create_list(:answer, 2) }
    before { get :index }
    it 'populates an array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, id: answer }
    it 'assign the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { get :new }
    it "assigns a new Question to @answer" do
      expect(assigns(:answer)).to be_a_new(Question)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do
    before { get :edit, id: answer }
    it 'assign the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it "renders edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "save the new answer in the database" do
        expect { post :create, answer: attributes_for(:answer) }.to change(Question, :count).by(1)
      end
      it "redirect to show view" do
        post :create, answer: attributes_for(:answer)
        expect(response).to redirect_to answer_path(assigns :answer)
      end
    end
    context "with invalid attributes" do
      it "doesn't save the new answer in the database" do
        expect { post :create, answer: attributes_for(:invalid_answer) }.to_not change(Question, :count)
      end
      it "re-render new view" do
        post :create, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it 'assign the requested answer to @answer' do
        patch :update, id: answer, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end

      it "changes answer attrs" do
        patch :update, id: answer, answer: { title: 'new title', body: 'new body' }
        answer.reload
        expect(answer.title).to eq 'new title'
        expect(answer.body).to eq 'new body'
      end

      it "redirect to the updated answer" do
        patch :update, id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to answer
      end
    end
    context "with invalid attributes" do
      before { patch :update, id: answer, answer: { title: 'new title', body: nil } }
      it "doesn't changes answer attrs" do
        answer.reload
        expect(answer.title).to eq 'MyString'
        expect(answer.body).to eq 'MyText'
      end

      it "re-render edit view" do
        expect(response).to render_template :edit
      end
    end
  end
  describe "DELETE #destroy" do
    before { answer }
    it "delete answer" do
      expect { delete :destroy, id: answer }.to change(Question, :count).by(-1)
    end
    it "redirect to index view" do
      expect(delete :destroy, id: answer).to redirect_to answers_path
    end
  end
end
