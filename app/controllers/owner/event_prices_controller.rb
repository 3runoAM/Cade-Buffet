class Owner::EventPricesController < ApplicationController
  def new
    check_event Event.find params[:event_id]
    @event_price = EventPrice.new
  end

  def create
    check_event Event.find(params[:event_price][:event_id])
    @buffet = @event.buffet
    @event_price = @event.event_prices.build(event_price_params)
    if @event.save
      redirect_to owner_buffet_event_path(@buffet.id, @event.id), notice: 'Preço cadastrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível cadastrar o preço'
      render 'new'
    end
  end

  def edit
    check_event Event.find(params[:event_id])
    @event_price = EventPrice.find params[:id]
  end

  def update
    check_event Event.find(params[:event_price][:event_id])
    @buffet = @event.buffet
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

  def check_event(event)
    if event.buffet.user == current_user
      @event = event
    else
      redirect_to owner_dashboards_path, alert: 'Você não tem permissão para acessar essa página'
    end
  end
end