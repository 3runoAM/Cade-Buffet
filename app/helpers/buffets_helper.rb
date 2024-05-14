module BuffetsHelper

  def render_edit_buffet_button(buffet)
    if current_user.id == buffet.user_id
      link_to I18n.t("helpers.models.buffet.edit"), edit_owner_buffet_path(buffet)
    end
  end
end
