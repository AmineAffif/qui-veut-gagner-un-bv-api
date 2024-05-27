Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions'
  }

  # Defines the root path route ("/")
  # root "home#index"
end
