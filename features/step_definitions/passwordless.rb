# frozen_string_literal: true

# Given(I am on the home page)
#     And I click "Log In with Email Link"
#     Then I should be on the sign_in page

Given('I am on the home page') do
  visit root_path
end

And('I follow {string}') do |link|
  click_link(link)
end

Then('I should be on the sign_in page') do
  expect(page).to have_current_path('/sign_in')
end

Given('I am on the sign_in page') do
  visit '/sign_in'
end

And('I press button {string}') do |button|
  click_button(button)
end

And('I fill in {string}') do |string|
  fill_in 'passwordless[email]', with: string
end

And('I exist as a user') do
  User.create({ name: 'Test User', role: 'coach', email: 'pleasework@gmail.com' })
  ActionMailer::Base.deliveries.clear
end

Then('the page should have {string}') do |string|
  expect(page).to have_content(string)
end

# Then('the user should receive a confirmation email') do
#     puts "Deliveries Array: #{ActionMailer::Base.deliveries.inspect}"
#     email = ActionMailer::Base.deliveries.last
#     email.from.should == "Fighting_Aggies_Application@example.com"
#     email.to.should == "faaplicationuser@gmail.com"
#     email.body.should include("You may have tried to login from the following device:")
# end
