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

  def edit
    @order = Order.find(params[:id])
    @buffet = Buffet.find_by(user: current_user)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(params.require(:order).permit(:adjustment, :adjustment_type, :adjustment_description,
                                                   :payment_method_id, :confirmation_date, :status))
      redirect_to owner_order_path(@order), notice: "Solicitação aprovada com sucesso"
    else
      @buffet = Buffet.find_by(user: current_user)
      flash.now[:notice] = "Problemas na análise"
      render :edit
    end
  end
end