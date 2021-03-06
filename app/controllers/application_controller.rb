class ApplicationController < ActionController::Base
  include Pundit

  # Just to avoid waiting long time when an exception occurs
  before_action :better_errors_hack, if: -> { Rails.env.development? }

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit? - utile si l'on souhaite traiter les droits de l'index dans policy"

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

 # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def current_user
    super || Guest.new
  end

  def user_signed_in?
    current_user.is_a?(User)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def better_errors_hack
    request.env['puma.config'].options.user_options.delete :app
  end

  def set_basket
    @basket = Basket_line.new
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

end

