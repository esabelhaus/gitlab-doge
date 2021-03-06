Dogeapp::Application.routes.draw do
  require 'sidekiq/web'
  require 'admin_constraint'
  mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new
  get '/sidekiq', to: "pages#show", id: "access_denied"

  match "/auth/:provider/callback", to: "sessions#create", :via => [:get, :post]
  get   '/auth/failure', to: 'sessions#failure'
  get   "/sign_out", to: "sessions#destroy"
  get   "/configuration", to: "application#configuration"

  get "/faq", to: "pages#show", id: "faq"

  resources :builds, only: [:create]

  resources :repos, only: [:index] do
    resource :activation, only: [:create]
    resource :deactivation, only: [:create]
  end

  resources :repo_syncs, only: [:index, :create]
  resource :user, only: [:show]

  root to: "home#index"
end
