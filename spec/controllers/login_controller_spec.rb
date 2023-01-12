require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  context 'when user email exists in User model' do
    let(:user) { User.create({ name: 'Test Admin', role: 'admin', email: 'user@gmail.com' }) }
    let(:email) { user.email }
    let(:request_params) { { 'omniauth.auth' => { 'extra' => { 'id_info' => { 'email' => email } } } } }

    before do
      allow(request).to receive(:env).and_return(request_params)
      allow(request).to receive(:host)
      get :omniauth, params: { provider: 'google_oauth2' }
    end

    it 'redirects to the login path' do
      expect(request).to redirect_to(login_path(email.gsub('.', '%1F')))
    end

    it 'sets session[:authenticated] to true' do
      expect(session[:authenticated]).to eq true
    end
  end

  context 'when user email does not exist in User model' do
    let(:email) { 'nonexistent@example.com' }
    let(:request_params) { { 'omniauth.auth' => { 'extra' => { 'id_info' => { 'email' => email } } } } }

    before do
      allow(request).to receive(:env).and_return(request_params)
      allow(request).to receive(:host)
      get :omniauth, params: { provider: 'google_oauth2' }
    end

    it 'does not set session[:authenticated]' do
      expect(session[:authenticated]).to be_nil
    end
  end
  describe '#login' do
    User.destroy_all
    let(:admin) { User.create({ name: 'Test Admin', role: 'Admin', email: 'user1@gmail.com' }) }
    let(:coach) { User.create({ name: 'Test Coach', role: 'Coach', email: 'user2@gmail.com' }) }

    before do
      session[:authenticated] = true
    end

    it 'redirects to admin_path if the user is an admin' do
      get :login, params: { email: admin.email.gsub('.', '%1F') }
      expect(response).to redirect_to(admin_path)
    end

    it 'redirects to dashboard_path if the user is a coach' do
      get :login, params: { email: coach.email.gsub('.', '%1F') }
      expect(response).to redirect_to(dashboard_path)
    end

    it 'redirects to root_path if the user does not exist' do
      get :login, params: { email: 'not_a_user@example.com' }
      expect(response).to redirect_to(root_path)
    end

    it 'redirects to root_path if session is not authenticated' do
      session[:authenticated] = false
      get :login, params: { email: admin.email.gsub('.', '%1F') }
      expect(response).to redirect_to(root_path)
    end
  end
  describe '#authorize' do
    let(:user) { User.create({ name: 'Test Admin', role: 'Admin', email: 'user1@gmail.com' }) }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'sets session[:authenticated] to true' do
      post :authorize
      expect(session[:authenticated]).to eq(true)
    end

    it 'redirects to the login path with the email' do
      email = user.email.gsub('.', '%1F')
      expect(controller).to receive(:redirect_to).with(login_path(email))
      post :authorize
    end
  end
end
