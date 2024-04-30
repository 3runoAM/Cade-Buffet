class Client::DashboardsController < ApplicationController
  before_action :authenticate_client
  def index
    @orders = Order.where(user_id: current_user.id)
  end
end
