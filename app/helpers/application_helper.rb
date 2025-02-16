module ApplicationHelper
  include Pagy::Frontend

  def pagination(obj)
    pagy_bootstrap_nav(obj) if obj.pages > 1
  end
end
