module ApplicationHelper
  def current_user_info
    "#{current_user.name} | #{current_user.email}"
  end
end
