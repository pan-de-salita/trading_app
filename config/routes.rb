Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }

  namespace :admin do
    resources :users, only: %i[new create edit index update destroy] do
      patch 'approve_trader_account'
      patch 'deny_trader_account'
    end
  end

  resources :stocks, only: %i[index show]

  resources :transactions, only: %i[index new create]

  resources :portfolio, only: %i[index show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Defines the root path route ("/")
  root to: 'pages#home'
end
