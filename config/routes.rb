Rails.application.routes.draw do
  get 'users/show'
  get 'games/random_question'
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions'
  }

  resources :admin_users, only: [:index, :show, :update, :destroy]

  resources :users, only: [:show, :index, :update, :destroy] do
    member do
      patch :update_avatar
    end
  end

  resources :questions, only: [:index, :show, :update, :create]

  resources :statistics, only: [:show, :update] do
    collection do
      get 'top_players'
    end
  end

  resources :games, only: [:create] do
    collection do
      get 'random_game'
      post 'reset_questions'
    end
  end
end
