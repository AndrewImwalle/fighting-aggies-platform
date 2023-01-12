# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#admin_authenticate' do
    context 'when the user is not an administrator' do
      before { session[:admin] = nil }

      it 'redirects to the root path' do
        get :admin_authenticate
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash notice' do
        get :admin_authenticate
        expect(flash[:notice]).to eq 'Please login as an administrator.'
      end
    end
  end

  describe '#coach_authenticate' do
    context 'when the user is not a coach' do
      before { session[:coach] = nil }

      it 'redirects to the root path' do
        get :coach_authenticate
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash notice' do
        get :coach_authenticate
        expect(flash[:notice]).to eq 'Please login as a coach.'
      end
    end
  end

  describe 'logout' do
    before do
      session[:authenticated] = true
      session[:coach] = true
      session[:admin] = true
      delete :logout
    end

    it 'sets session[:authenticated] to false' do
      expect(session[:authenticated]).to eq(false)
    end

    it 'sets session[:coach] to false' do
      expect(session[:coach]).to eq(false)
    end

    it 'sets session[:admin] to false' do
      expect(session[:admin]).to eq(false)
    end

    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end
  end
end
