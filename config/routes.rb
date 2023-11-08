Rails.application.routes.draw do
  root "home#index"
  namespace :mouse_studio_admin do
    resources :wallpapers
    get  "sign_in", to: "sessions#new"
    post "sign_in", to: "sessions#create"

    delete :sessions, to: "sessions#destroy"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
