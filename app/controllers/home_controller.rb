class HomeController < ApplicationController
  before_action :ensure_registered_buffet
  def index
    @buffets = Buffet.all
  end

  def show
    @buffet = Buffet.find(params[:id])
    @events = @buffet.events
  end
end
