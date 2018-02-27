require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) { FactoryBot.create :user}

  describe 'new' do
    before do
      request.session[:user_id] = user.id
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'sets an instance variable with a new idea' do
      get :new
      expect(assigns(:idea)).to be_a_new(Idea)
    end
  end

  describe 'create' do
    before do
      request.session[:user_id] = user.id
    end

    context 'with valid parameters' do
      def valid_request
        post :create, params: {idea: FactoryBot.attributes_for(:idea)}
      end

      it 'adds an idea to the db' do
        count_before = Idea.count
        valid_request
        count_after = Idea.count

        expect(count_after).to eq(count_before + 1)
      end

      it 'redirects to the ideas index page' do
        valid_request

        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      def invalid_request
        post :create, params: {idea: FactoryBot.attributes_for(:idea, title: nil)}
      end

      it 'fails to add ideas to the db' do
        count_before = Idea.count
        invalid_request
        count_after = Idea.count

        expect(count_after).to eq(count_before)
      end

      it 'renders the new template page again' do
        invalid_request

        expect(response).to render_template(:new)
      end
    end
  end
end
