class AdminController < ApplicationController
  before_action :admin_authenticate
  def dashboard
    @users = User.all
  end
end
