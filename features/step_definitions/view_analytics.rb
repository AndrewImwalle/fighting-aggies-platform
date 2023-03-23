Given('player {string} exists') do |string|
  Player.create(name: string)
end

Given('{string} has run a route') do |string|
  RouteInstance.create(player_id: Player.find_by(name: string).id, route_name: 'curl', success: 1, date: DateTime.strptime('03/02/2023', '%m/%d/%Y'))
end

When('I click the remove link') do
  link = find('.remove-link')
  link.click
end

When('I submit the form') do
  find('input[type="submit"]').click
end

Then('I am on the Route Instances Index page') do
  expect(page).to have_current_path("#{route_instances_path}/*/*/*/*")
end

Then('I am on the Players Index page') do
  expect(page).to have_current_path(players_index_path)
end

Then('I am on the By Player page') do
  expect(current_path[0..route_instances_by_player_path.length]).to eq(route_instances_by_player_path)
end

Then('I am on the Player Show page for {string}') do |string|
  expect(current_path[0..players_show_path(id: Player.find_by(name: string).id).length]).to eq(players_show_path(id: Player.find_by(name: string).id))
end
