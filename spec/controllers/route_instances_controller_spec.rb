require 'rails_helper'

RSpec.describe RouteInstancesController, type: :controller do
  before(:each) do
    ActiveRecord::Base.connection.execute('DELETE FROM route_instances')
  end
  describe 'GET #index' do
    let!(:player1) { Player.create(name: 'John Doe') }
    let!(:player2) { Player.create(name: 'Jane') }
    let!(:route_instance1) { RouteInstance.create(player_id: player1.id, route_name: 'comeback', play_name: 'zebra 42', practice_id: 2, success: 1) }
    let!(:route_instance2) { RouteInstance.create(player_id: player1.id, route_name: 'curl', play_name: 'curl 12', practice_id: 3, success: 0) }
    let!(:route_instance3) { RouteInstance.create(player_id: player2.id, route_name: 'curl', play_name: 'curl 1', practice_id: 2, success: 0) }
    it 'gets routes based on player id' do
      session[:coach] = true
      get :index, params: { player_id: player1.id, route_name: '*', play_name: '*', practice_id: '*' }
      expect(assigns(:route_instances)).to eq([route_instance1, route_instance2])
    end
    it 'gets routes based on route name' do
      session[:coach] = true
      get :index, params: { player_id: '*', route_name: 'curl', play_name: '*', practice_id: '*' }
      expect(assigns(:route_instances)).to eq([route_instance2, route_instance3])
    end
    it 'gets routes based on play name' do
      session[:coach] = true
      get :index, params: { player_id: '*', route_name: '*', play_name: 'curl 12', practice_id: '*' }
      expect(assigns(:route_instances)).to eq([route_instance2])
    end
    it 'gets routes based on practice id' do
      session[:coach] = true
      get :index, params: { player_id: '*', route_name: '*', play_name: '*', practice_id: 2 }
      expect(assigns(:route_instances)).to eq([route_instance1, route_instance3])
    end
    it 'gets routes based on all parameters' do
      session[:coach] = true
      get :index, params: { player_id: player2.id, route_name: 'curl', play_name: 'curl 1', practice_id: '2' }
      expect(assigns(:route_instances)).to eq([route_instance3])
    end
    it 'returns an empty array when no routes available' do
      session[:coach] = true
      get :index, params: { player_id: 9, route_name: 'blah', play_name: '*', practice_id: '*' }
      expect(assigns(:route_instances)).to eq([])
    end
    it 'calculates the proper success rate' do
      session[:coach] = true
      get :index, params: { player_id: '*', route_name: '*', play_name: '*', practice_id: '*' }
      expect(assigns(:percent_success)).to eq(1.0 / 3 * 100)
    end
  end

  describe 'GET #by_player' do
    let!(:player1) { Player.create(name: 'John Doe') }
    let!(:player2) { Player.create(name: 'Jane') }
    let!(:route_instance1) { RouteInstance.create(player_id: player1.id, route_name: 'curl', play_name: 'zebra 42', practice_id: 2, success: 1, date: DateTime.strptime('03/02/2023', '%m/%d/%Y')) }
    let!(:route_instance2) { RouteInstance.create(player_id: player1.id, route_name: 'curl', play_name: 'curl 12', practice_id: 3, success: 0, date: DateTime.strptime('03/07/2023', '%m/%d/%Y')) }
    let!(:route_instance3) { RouteInstance.create(player_id: player2.id, route_name: 'curl', play_name: 'curl 1', practice_id: 2, success: 0, date: DateTime.strptime('03/08/2023', '%m/%d/%Y')) }
    it 'populates the data array with successes and totals' do
      session[:coach] = true
      get :by_player, params: { routes: 'curl' }
      expect(assigns(:data)).to eq([[player2.id, { 'curl' => [0, 1] }], [player1.id, { 'curl' => [1, 2] }]])
    end
    it 'populates the array all_data with successes and totals' do
      session[:coach] = true
      get :by_player, params: { routes: 'curl' }
      expect(assigns(:all_data)).to eq({ player1.id => { 'curl' => [1, 2] }, player2.id => { 'curl' => [0, 1] } })
    end
    it 'sets start day to the minimum date' do
      session[:coach] = true
      get :by_player
      expect(assigns(:start_date)).to eq(route_instance1.date)
    end
    it 'sets end day to the maximum date' do
      session[:coach] = true
      get :by_player
      expect(assigns(:end_date)).to eq(route_instance3.date)
    end
    it 'sets routes to an empty array' do
      session[:coach] = true
      get :by_player
      expect(assigns(:routes)).to eq([])
    end
    it 'sets all routes to an array of routes' do
      session[:coach] = true
      get :by_player
      expect(assigns(:all_routes)).to eq(%w[curl overall])
    end
    it 'sets sort by to overall' do
      session[:coach] = true
      get :by_player, params: { sort_by: 'overall' }
      expect(assigns(:sort_by)).to eq('overall')
    end
    it 'sets sort by to a route' do
      session[:coach] = true
      get :by_player, params: { sort_by: 'curl' }
      expect(assigns(:sort_by)).to eq('curl')
    end
  end
end
