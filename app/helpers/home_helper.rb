module HomeHelper

  def render_request_order_button(buffet_id, event_id)
    if user_signed_in?
      link_to I18n.t("helpers.models.order.submit"), new_client_order_path(buffet_id: buffet_id, event_id: event_id)
    end
  end
end