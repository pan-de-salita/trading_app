Rails.application.routes.draw do
  # for letter_opener_web to work
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users, controllers: {
    registrations: 'traders/registrations'
  }

  namespace :admin do
    resources :users, only: %i[new create edit index update destroy]
  end

  root to: 'pages#home'
end
