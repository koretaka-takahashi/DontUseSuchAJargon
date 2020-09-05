class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
  end

  def set_search
    @search = Term.ransack(params[:q])
    @search_terms = @search.result(distinct: true).order(created_at: :desc)
  end
end
