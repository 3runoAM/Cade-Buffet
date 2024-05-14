class Owner::EventPricesController < ApplicationController
  before_action :check_event, only: [:new, :edit, :create, :update]
  def new
    @event_price = EventPrice.new
  end

  def create
    @event_price = @event.event_prices.build(event_price_params)
    if @event.save
      redirect_to owner_buffet_event_path(@event.buffet, @event), notice: t("notices.models.event_price.register.success")
    else
      flash.now[:alert] =  t("notices.models.event_price.register.fail")
      render 'new'
    end
  end

  def edit
    @event_price = EventPrice.find params[:id]
  end

  def update
    @event_price = EventPrice.find params[:id]
    if @event_price.update(event_price_params)
      redirect_to owner_buffet_event_path(@event.buffet, @event), notice: t("notices.update.success", model_name: EventPrice.model_name.human)
    else
      flash.now[:alert] = t("notices.update.fail", model_name: EventPrice.model_name.human.downcase)
      render 'edit'
    end
  end

  private

  def event_price_params
    params.require(:event_price).permit(:standard_price, :extra_guest_price, :extra_hour_price, :day_type)
  end

  def check_event
    event = Event.find params[:event_id] || params[:event_price][:event_id]
    if event.buffet.user == current_user
      @event = event
    else
      redirect_to owner_dashboards_path, alert: t("notices.access.access_denied")
    end
  end
end