Rails.application.routes.draw do
  get 'users/show'
  get 'games/random_question'
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'users/:id', to: 'users#show'

  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions'
  }
  
  resources :questions, only: [:index, :show, :update, :create]
  
  resources :statistics, only: [:show, :update]
  
  resources :games, only: [:create] do
    collection do
      get 'random_game'
      post 'reset_questions'
    end
  end
end
