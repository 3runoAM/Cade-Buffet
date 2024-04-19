class Owner::EventPricesController < ApplicationController
  def new
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.find params[:event_id]
    @event_price = EventPrice.new
  end

  def create
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.find params[:event_id]
    @event.event_prices.build(event_price_params)
    if @event.save
      redirect_to owner_buffet_event_path(@buffet.id, @event.id), notice: 'Preço cadastrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível cadastrar o preço'
      render 'new'
    end
  end

  def edit
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.find params[:event_id]
    @event_price = EventPrice.find params[:id]
  end

  def update
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.find params[:event_id]
    @event_price = EventPrice.find params[:id]
    if @event_price.update(event_price_params)
      redirect_to owner_buffet_event_path(@buffet.id, @event.id), notice: 'Preço atualizado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível atualizar o preço'
      render 'edit'
    end

  end

  private

  def event_price_params
    params.require(:event_price).permit(:standard_price, :extra_guest_price, :extra_hour_price, :day_type)
  end
end