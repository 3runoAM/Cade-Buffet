class HomeController < ApplicationController
  before_action :ensure_registered_buffet
  def index
    @buffets = Buffet.all
  end
end
