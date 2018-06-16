class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :get_employee, :get_all_games

  def get_all_games
      return Game.all.order(id: :asc).limit(100)
  end

  def get_employee(player_id)
      return Employee.find_by_id(player_id)
  end
end
