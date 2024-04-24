module ApplicationHelper
  def current_user_info
    "#{current_user.name} | #{current_user.email}"
  end

  def render_user_area
    case current_user.role
    when :owner
      "<li>#{link_to 'Área do proprietário', owner_dashboards_path}</li>"
    when :client
      "#{link_to 'Área do cliente', root_path}</li>"
    end
  end
end
