class Owner::DashboardsController < ApplicationController
  before_action :ensure_registered_buffet, only: [:index]
  def index
    @buffet = Buffet.find_by(user: current_user)
    @events = @buffet.events
  end
end