class ApplicationController < ActionController::Base
  protect_from_forgery

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # the default alert and notice
  add_flash_types :success, :danger, :info

  private

  def retrieve_full_error_message(model)
    model.errors.full_messages.join('; ')
  end
end
