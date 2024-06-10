Rails.application.routes.draw do
  get 'games/random_question'
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions'
  }
  
  resources :questions, only: [:index, :show, :update, :create]
  
  resources :statistics, only: [:show, :update]

  resources :games, only: [:create] do
    collection do
      get 'random_game'
    end
  end
end
