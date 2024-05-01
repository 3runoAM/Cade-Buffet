class  Client::OrdersController < ApplicationController
  before_action :authenticate_client
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
      return redirect_to client_order_path(@order), notice: 'Evento solicitado com sucesso'
    end
    @buffet = Buffet.find(params[:order][:buffet_id])
    @event = @buffet.events.find(params[:order][:event_id])
    flash.now[:notice] = 'Não foi possível solicitar o evento'
    render :new
  end

  def show
    @order = Order.find(params[:id])
  end
end