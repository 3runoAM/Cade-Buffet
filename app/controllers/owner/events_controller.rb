class Owner::EventsController < ApplicationController
  def new
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.new
  end

  def create
    @buffet = Buffet.find params[:buffet_id]
    @event = @buffet.events.build(event_params)
    if @event.save
      return redirect_to [:owner, @buffet, @event], notice: "Evento criado com sucesso"
    end
    flash.now[:notice] = "Problema ao criar evento"
    render 'new'
  end

  def show
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.find params[:id]
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :min_guests, :max_guests, :standard_duration,
                                  :menu, :offsite_event, :offers_alcohol, :offers_decoration,
                                  :offers_valet_parking)
  end
end