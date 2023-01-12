# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    coach_authenticate
  end
end
