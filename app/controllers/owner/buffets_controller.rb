class Owner::BuffetsController < ApplicationController
  before_action :authenticate_owner, only: [:new, :create]
  before_action :set_buffet, only: [:edit, :show, :edit, :update]
  before_action :check_buffet_owner, only: [:update]

  def new
    @buffet = Buffet.new
    @buffet.build_address
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.user_id = current_user.id
    if @buffet.save
      return redirect_to owner_buffet_path(@buffet.id), notice: "#{@buffet.brand_name} criado com sucesso!"
    end
    flash.now[:notice] = 'Problemas ao criar Buffet'
    render 'new'
  end

  def show; end

  def edit; end

  def update
    if @buffet.update(buffet_params)
      return redirect_to owner_buffet_path(@buffet.id), notice: 'Buffet atualizado com sucesso'
    end
    flash.now[:notice] = 'Erro ao atualizar Buffet'
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
    redirect_to root_path, notice: "Acesso negado" if current_user.id != @buffet.user_id
  end
end