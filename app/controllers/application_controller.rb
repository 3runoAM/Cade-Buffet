class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :cpf])
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.role == 'owner' && resource.buffet.nil?
      return new_owner_buffet_path
    end
    super
  end

  def ensure_registered_buffet
    unless current_user.nil?
      redirect_to new_owner_buffet_path if current_user.role == 'owner' && current_user.buffet.nil?
    end
  end

  def authenticate_owner
    unless current_user && current_user.role == 'owner'
      redirect_to root_path, notice: t('notices.access.access_denied')
    end
  end

  def authenticate_client
    unless current_user && current_user.role == 'client'
      redirect_to root_path, notice: t('notices.access.access_denied')
    end
  end
end
