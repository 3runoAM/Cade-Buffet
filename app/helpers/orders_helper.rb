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
end