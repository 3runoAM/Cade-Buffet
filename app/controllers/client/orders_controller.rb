class  Client::OrdersController < ApplicationController
  before_action :authenticate_client
  before_action :check_order_owner, only: [:show, :update]
  def new
    @buffet = Buffet.find(params[:buffet_id])
    @event = @buffet.events.find(params[:event_id])
    @order = Order.new
  end

  def create
    @order = Order.new(params.require(:order).permit(:event_date, :total_guests, :address,
                                                     :additional_info, :buffet_id, :event_id))
    @order.user_id = current_user.id
    if @order.save
      return redirect_to client_order_path(@order), notice: t("notices.models.order.request.success")
    end
    @buffet = Buffet.find(params[:order][:buffet_id])
    @event = @buffet.events.find(params[:order][:event_id])
    flash.now[:notice] = t("notices.models.order.request.fail")
    render 'new'
  end

  def update
    @order = Order.find(params[:id])

    if @order.confirmation_date < Date.today
      @order.rejected!
      return redirect_to client_order_path(@order), notice: t("notices.models.order.expired_date")
    end

    if @order.update(params.require(:order).permit(:status))
      return redirect_to client_order_path(@order), notice: t("notices.models.order.confirmation.success")
    end
    flash.now[:notice] = t("notices.models.order.confirmation.success")
    render :new
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def check_order_owner
    @order = Order.find(params[:id])
    redirect_to root_path, notice: t("notices.access.access_denied") if current_user.id != @order.user_id
  end
end