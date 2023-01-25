# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PracticeVideosController, type: :controller do
  describe 'POST #create' do
    it 'creates a new practice video with valid params' do
      session[:data_manager] = true
      video_params = { filename: 'test_video.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description' }
      expect { post :create, params: { practice_video: video_params } }.to change(PracticeVideo, :count).by(1)
    end

    it 'does not create a new practice video with invalid params' do
      session[:data_manager] = true
      video_params = { filename: '', video_name: '', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description' }
      expect { post :create, params: { practice_video: video_params } }.to_not change(PracticeVideo, :count)
    end
  end

  describe 'PATCH #update' do
    let(:practice_video) { PracticeVideo.create(filename: 'test_video.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description') }

    it 'updates an existing practice video with valid params' do
      session[:data_manager] = true
      video_params = { video_name: 'New Test Video', description: 'New test video description' }
      patch :update, params: { id: practice_video.id, practice_video: video_params }
      practice_video.reload
      expect(practice_video.video_name).to eq('New Test Video')
      expect(practice_video.description).to eq('New test video description')
    end

    it 'does not update an existing practice video with invalid params' do
      session[:data_manager] = true
      video_params = { video_name: '', description: '' }
      patch :update, params: { id: practice_video.id, practice_video: video_params }
      practice_video.reload
      expect(practice_video.video_name).to_not eq('')
      expect(practice_video.description).to_not eq('')
    end
  end

  describe 'DELETE #destroy' do
    let(:practice_video) { PracticeVideo.create(filename: 'test_video.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description') }

    it 'deletes an existing practice video' do
      session[:data_manager] = true
      delete :destroy, params: { id: practice_video.id }
      expect(PracticeVideo.find_by(id: practice_video.id)).to eq(nil)
    end
  end

  describe 'GET #show' do
    let(:practice_video) { PracticeVideo.create(filename: 'test_video.mp4', video_name: 'Test Video', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video description') }

    it 'returns the details of an existing practice video' do
      session[:data_manager] = true
      get :show, params: { id: practice_video.id }
      expect(assigns(:practice_video)).to eq(practice_video)
    end
  end

  describe 'GET #index' do
    let!(:video1) { PracticeVideo.create(filename: 'test_video1.mp4', video_name: 'Test Video 1', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video 1 description') }
    let!(:video2) { PracticeVideo.create(filename: 'test_video2.mp4', video_name: 'Test Video 2', video_create_date: '2023-08-01T01:23:45Z', video_upload_date: '2023-08-01T01:23:45Z', description: 'Test video 2 description') }
    it 'lists all existing practice videos' do
      session[:data_manager] = true
      get :index
      expect(assigns(:practice_videos).find { |video| video[:id] == video1.id }).to_not be_nil
      expect(assigns(:practice_videos).find { |video| video[:id] == video2.id }).to_not be_nil
    end
  end
end