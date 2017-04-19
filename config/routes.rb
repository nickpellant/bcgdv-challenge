Rails.application.routes.draw do
  namespace :api do
    resources :images, only: %i[create]
  end
end
