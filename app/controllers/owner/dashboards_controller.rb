class Owner::DashboardsController < ApplicationController
  def index
    @buffet = Buffet.find_by(user_id: current_user.id)
    @events = @buffet.events
  end
end