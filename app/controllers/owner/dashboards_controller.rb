class Owner::DashboardsController < ApplicationController
  before_action :ensure_registered_buffet, only: [:index]
  def index
    @buffet = Buffet.find_by(user_id: current_user.id)
    @events = @buffet.events
  end
end