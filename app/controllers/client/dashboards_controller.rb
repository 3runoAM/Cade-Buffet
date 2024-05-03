class Client::DashboardsController < ApplicationController
  before_action :authenticate_client
  def index
    orders = Order.where(user_id: current_user.id)
    @pending_orders = orders.where(status: :pending)
    @confirmed_orders = orders.where(status: :confirmed)
    @approved_orders = orders.where(status: :approved)
    @rejected_orders = orders.where(status: :rejected)
  end
end
