require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    it 'creates a new user with valid params' do
      user_params = { name: 'John Doe', email: 'johndoe@example.com', role: 'Coach' }
      expect { post :create, params: { user: user_params } }.to change(User, :count).by(1)
    end

    it 'does not create a new user with invalid params' do
      user_params = { name: '', email: '', role: 'Coach' }
      expect { post :create, params: { user: user_params } }.to_not change(User, :count)
    end
  end

  describe 'PATCH #update' do
    let(:user) { User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach') }

    it 'updates an existing user with valid params' do
      user_params = { name: 'Jane Doe', email: 'janedoe@example.com' }
      patch :update, params: { id: user.id, user: user_params }
      user.reload
      expect(user.name).to eq('Jane Doe')
      expect(user.email).to eq('janedoe@example.com')
    end

    it 'does not update an existing user with invalid params' do
      user_params = { name: '', email: '' }
      patch :update, params: { id: user.id, user: user_params }
      user.reload
      expect(user.name).to eq('John Doe')
      expect(user.email).to eq('johndoe@example.com')
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach') }

    it 'deletes an existing user' do
      delete :destroy, params: { id: user.id }
      expect(User.find_by(id: user.id)).to eq(nil)
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach') }

    it 'returns the details of an existing user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #index' do
    let!(:user1) { User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach') }
    let!(:user2) { User.create(name: 'Jane Doe', email: 'janedoe@example.com', role: 'Admin') }

    it 'lists all existing users' do
      get :index
      expect(assigns(:users)).to match_array([user1, user2])
    end
  end
end
