Rails.application.routes.draw do
  root "posts#index"

  resources :posts, except: %i[destroy edit update show]

  get "up" => "rails/health#show", as: :rails_health_check
end
