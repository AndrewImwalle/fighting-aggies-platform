class RouteInstancesController < ApplicationController
  before_action :coach_authenticate
  def index
    filters = { player_id: params[:player_id], route_name: params[:route_name], practice_id: params[:practice_id], play_name: params[:play_name] }

    conditions = []
    values = []

    filters.each do |field, value|
      if value.present? && value != '*'
        conditions << "#{field} in (?)"
        values << value
      else
        conditions << "#{field} IS NOT NULL"
      end
    end
    route_instances = RouteInstance.where(conditions.join(' AND '), *values)
    @route_instances = if route_instances.any?
                         route_instances
                       else
                         []
                       end
    total_instances = route_instances.count
    successful_instances = route_instances.where(success: 1).count
    @percent_success = (successful_instances.to_f / total_instances) * 100
  end

  def by_player
    require('uri')
    if params[:start_date].present? && params[:end_date].present?
      @start_date = Date.parse(params[:start_date])
      @end_date = Date.parse(params[:end_date])
    else
      @start_date = RouteInstance.distinct.pluck(:date).min
      @end_date = RouteInstance.distinct.pluck(:date).max
    end
    @data = {}
    @all_data = {}
    @routes = if params[:routes].present?
                params[:routes].split(',')
              else
                []
              end
    @all_routes = RouteInstance.distinct.pluck(:route_name)
    @all_routes.push('overall')
    RouteInstance.where('date >= ?', @start_date).where('date <= ?', @end_date).each do |route_instance|
      player_id = route_instance.player_id
      route_name = route_instance.route_name
      success = route_instance.success
      if @routes.include?(route_name)
        @data[player_id] = {} if @data[player_id].nil?
        @data[player_id][route_name] = [0, 0] if @data[player_id][route_name].nil?

        @data[player_id][route_name][0] += success
        @data[player_id][route_name][1] += 1
      end
      @all_data[player_id] = {} if @all_data[player_id].nil?
      @all_data[player_id][route_name] = [0, 0] if @all_data[player_id][route_name].nil?

      @all_data[player_id][route_name][0] += success
      @all_data[player_id][route_name][1] += 1
    end

    @sort_by = params[:sort_by]
    @ascending = params[:ascending]
    if @sort_by.present?
      @all_data = if @sort_by == 'overall'
                    @all_data.sort_by do |_player_id, routes|
                      total_instances = 0
                      successful_instances = 0
                      routes.each do |_route_name, data|
                        total_instances += data[1]
                        successful_instances += data[0]
                      end
                      total_instances.positive? ? params[:ascending].to_i * successful_instances.to_f / total_instances.to_f : 0
                    end
                  else
                    @all_data.sort_by do |_player_id, routes|
                      if routes[@sort_by].present? && (routes[@sort_by][1]).positive?
                        params[:ascending].to_i * routes[@sort_by][0].to_f / routes[@sort_by][1].to_f
                      else
                        0
                      end
                    end
                  end
    else
      @data = @data.sort_by do |player_id, _routes|
        Player.find_by(id: player_id).name
      end
    end
  end
end
