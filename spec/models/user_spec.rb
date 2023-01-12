require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creates' do
    it 'creates a new user with a name, email, and role' do
      user = User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach')

      expect(user.name).to eq('John Doe')
      expect(user.email).to eq('johndoe@example.com')
      expect(user.role).to eq('Coach')
    end
  end

  describe 'update' do
    it "updates an existing user's name and email" do
      user = User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach')
      user.update(name: 'Jane Doe', email: 'janedoe@example.com')

      expect(user.name).to eq('Jane Doe')
      expect(user.email).to eq('janedoe@example.com')
    end
  end

  describe 'destroy' do
    it 'deletes an existing user' do
      user = User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach')
      user.destroy

      expect(User.find_by(id: user.id)).to be_nil
    end
  end

  describe 'show' do
    it 'returns the details of an existing user' do
      user = User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach')
      shown_user = User.find(user.id)

      expect(shown_user.name).to eq(user.name)
      expect(shown_user.email).to eq(user.email)
      expect(shown_user.role).to eq(user.role)
    end
  end

  describe 'index' do
    it 'lists all existing users' do
      user1 = User.create(name: 'John Doe', email: 'johndoe@example.com', role: 'Coach')
      user2 = User.create(name: 'Jane Doe', email: 'janedoe@example.com', role: 'Admin')
      users = User.all

      expect(users.count).to eq(2)
      expect(users).to include(user1)
      expect(users).to include(user2)
    end
  end
end
