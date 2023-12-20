Rails.application.routes.draw do
  resources :candidates, only: [:new, :create]
  resources :voters, only: [:new, :create, :update]

  get "vote" => "candidates#vote"
  get "results" => "candidates#results"

  get "start" => "voters#new"
  get "sign_out" => "application#sign_out"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "candidates#results"
end
