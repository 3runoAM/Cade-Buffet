class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @order = Order.find(params[:order_id])
    @messages = Message.where(order: @order).order(sent_at: :desc)
    @message = Message.new
  end

  def create
    @message = Message.new(params.require(:message).permit(:content, :order_id))
    @message.user = current_user
    @message.sent_at = DateTime.now
    if @message.save
      return redirect_to messages_path(order_id: @message.order), notice: t("notices.models.messages.success")
    end
    flash.now[:notice] = t("notices.models.messages.fail")
    redirect_to messages_path(order_id: @message.order)
  end
end