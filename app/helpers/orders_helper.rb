module OrdersHelper
  def render_confirm_button(order)
    if order.status == 'approved' && order.confirmation_date > Date.today
      button_to 'Confirmar evento', client_order_path(order, order: { status: :confirmed }), method: :patch
    end
  end

  def render_reject_order_button(order)
    if order.status == 'pending' || order.status == 'approved'
      button_to 'Rejeitar evento', client_order_path(order, order: { status: :rejected} ), method: :patch
    end
  end

  def render_buffet_answer(order)
    if order.status == "approved" || @order.status == "confirmed"
      render partial: "shared/order_details", locals: {model: order}
    end
  end
end