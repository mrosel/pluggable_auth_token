PluggableAuthToken::Engine.routes.draw do
 # devise_for :users, controllers: {
 #    sessions: 'users/sessions',
 #    registrations: 'users/registrations'
 #  }
  devise_scope :user do
    namespace :users do
      resources :sessions, path: '/sign_in', only: :create
      resources :registrations, path: '/', only: :create
    end
  end
end
