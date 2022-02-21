require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  sign_in_user
  let(:question) { create(:question, { user: @user }) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2, { user: @user }) }

    before { get :index }
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do

    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do

    before { get :edit, params: { id: question } }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { question: { title: 'MyString', body: 'MyText' } } }.to change(Question, :count).by(1)
      end

      it 'renders show view' do
        post :create, params: { question: { title: 'MyString', body: 'MyText' } }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: { title: nil, body: nil } } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: { title: nil, body: nil } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do

    context 'valid attributes' do
      it 'assigns requested question to @question' do
        patch :update, params: { id: question, question: { title: 'MyString', body: 'MyText' } }
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question, question: { title: 'newString', body: 'newText' } }
        question.reload
        expect(question.title).to eq 'newString'
        expect(question.body).to eq 'newText'
      end

      it 'redirects to the updated question' do
        patch :update, params: { id: question, question: { title: 'MyString', body: 'MyText' } }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: question, question: { title: 'newString', body: nil } } }
      it 'does not change question attributes' do
        question.reload
        expect(question.title).to eq 'TitleQuestion'
        expect(question.body).to eq 'BodyQuestion'
      end

      it 're-renders edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }

    it 'deletes question' do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
