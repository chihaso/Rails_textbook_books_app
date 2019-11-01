# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :default_url_options
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :switch_locale

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def after_sign_in_path_for(resources)
    books_path
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:postal_code, :street_address, :self_introduction, :avatar, :name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:postal_code, :street_address, :self_introduction, :avatar, :name])
    end
end
