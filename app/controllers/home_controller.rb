class HomeController < ApplicationController
  before_action :ensure_registered_buffet
  def index; end
end
