class Owner::OrdersController < ApplicationController
  before_action :authenticate_owner
  before_action :ensure_registered_buffet, only: [:index]

  def index
    buffet = Buffet.find_by(user: current_user)
    orders = Order.where(buffet_id: buffet.id)
    @pending_orders = orders.where(status: :pending)
    @confirmed_orders = orders.where(status: :confirmed)
    @approved_orders = orders.where(status: :approved)
    @rejected_orders = orders.where(status: :rejected)
  end

  def show
    @order = Order.find(params[:id])
  end
end