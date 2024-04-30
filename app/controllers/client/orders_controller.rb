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
    set_address_if_blank
    @order.user_id = current_user.id
    @order.code = SecureRandom.alphanumeric(8).upcase
    if @order.save
      return redirect_to client_order_path(@order), notice: 'Evento solicitado com sucesso'
    end
    flash.now[:notice] = 'Não foi possível solicitar o evento'
    render :new
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_address_if_blank
    @order.address = @order.buffet.address.full_address if @order.address.blank?
  end
end