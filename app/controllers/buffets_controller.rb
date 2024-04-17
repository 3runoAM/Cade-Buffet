class BuffetsController < ApplicationController
  before_action :authenticate_owner, only: [:new, :create]
  def new
    @buffet = Buffet.new
    @buffet.build_address
  end

  def create
    @buffet = Buffet.new(params.require(:buffet).permit(:brand_name, :company_name, :crn, :phone, :email,
                                                        :description, address_attributes: [:street_name,
                                                         :house_or_lot_number, :neighborhood, :city, :state, :zip],
                                                        payment_method_ids: []))
    @buffet.user_id = current_user.id
    puts params
    if @buffet.save
      return redirect_to @buffet, notice: "#{@buffet.brand_name} criado com sucesso!"
    else
      puts @buffet.errors.full_messages
    end
    flash.now[:notice] = 'Problemas ao criar Buffet'
    render 'new'
  end

  def show
    @buffet = Buffet.find params[:id]
  end
end