# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Passwordless::ControllerHelpers

  helper_method :current_user

  def admin_authenticate
    if session[:coach]
      redirect_to dashboard_path
    elsif session[:admin].blank? || !session[:admin]
      redirect_to root_path
      flash[:notice] = 'Please login as an administrator.'
    end
  end

  def coach_authenticate
    if session[:admin]
      redirect_to admin_path
    elsif session[:coach].blank? || !session[:coach]
      redirect_to root_path
      flash[:notice] = 'Please login as a coach.'
    end
  end

  def logout
    session[:authenticated] = false
    session[:coach] = false
    session[:admin] = false
    redirect_to root_path
  end

  private

  def current_user
    @current_user ||= authenticate_by_session(User)
  end
end
