Rails.application.routes.draw do
  root 'books#index'

  resources :books do
    collection do
      get :search
    end
    resources :reviews, only: %i[create update destroy]
    resources :reading_sessions, only: %i[create]
  end

  resources :authors, except: %i[destroy]
  resources :shelves do
    member do
      post :add_book
      delete :remove_book
    end
  end
  resources :reading_sessions, only: %i[index]

  get 'dashboard', to: 'dashboard#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'register', to: 'registrations#new'
  post 'register', to: 'registrations#create'

  get 'up' => 'rails/health#show', as: :rails_health_check
end