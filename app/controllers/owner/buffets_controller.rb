class Owner::BuffetsController < ApplicationController
  before_action :authenticate_owner, only: [:new, :create, :edit, :update, :show]
  before_action :set_buffet, only: [:edit, :show, :edit, :update]
  before_action :check_buffet_owner, only: [:edit, :update]

  def new
    @buffet = Buffet.new
    @buffet.build_address
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.user = current_user
    if @buffet.save
      return redirect_to owner_buffet_path(@buffet), notice: t("notices.create.success", model_name: Buffet.model_name.human)
    end
    flash.now[:notice] = t("notices.create.fail", model_name: Buffet.model_name.human.downcase)
    render 'new'
  end

  def show; end

  def edit; end

  def update
    if @buffet.update(buffet_params)
      return redirect_to owner_buffet_path(@buffet), notice: t("notices.update.success", model_name: Buffet.model_name.human)
    end
    flash.now[:notice] = t("notices.update.fail", model_name: Buffet.model_name.human.downcase)
    render 'edit'
  end

  private

  def set_buffet
    @buffet = Buffet.find params[:id]
  end

  def buffet_params
    params.require(:buffet).permit(:brand_name, :company_name, :crn, :phone, :email,
                                   :description, address_attributes: [:id, :street_name,
                                    :house_or_lot_number, :neighborhood, :city, :state, :zip],
                                   payment_method_ids: [])
  end

  def check_buffet_owner
    set_buffet
    redirect_to root_path, notice: t("notices.access.access_denied") if current_user != @buffet.user
  end
end