class Owner::EventsController < ApplicationController
  def new
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.new
  end

  def create
    @buffet = Buffet.find params[:buffet_id]
    @event = @buffet.events.build(event_params)
    if @event.save
      return redirect_to owner_buffet_event_path(@buffet, @event), notice: t("notices.create.success", model_name: Event.model_name.human)
    end
    flash.now[:notice] = t("notices.create.fail", model_name: Event.model_name.human.downcase)
    render 'new'
  end

  def show
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.find params[:id]
  end

  def edit
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.find params[:id]
  end

  def update
    @buffet = Buffet.find params[:buffet_id]
    @event = Event.find params[:id]
    if @event.update(event_params)
      return redirect_to owner_buffet_event_path(@buffet, @event), notice: t("notices.update.success", model_name: Event.model_name.human)
    end
    flash.now[:notice] = t("notices.update.success", model_name: Event.model_name.human.downcase)
    render 'edit'
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :min_guests, :max_guests, :standard_duration,
                                  :menu, :offsite_event, :offers_alcohol, :offers_decoration,
                                  :offers_valet_parking, photos: [])
  end
end