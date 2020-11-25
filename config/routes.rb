Rails.application.routes.draw do
  devise_for :users
  root "genres#index"
  resources :users, only: [:index, :show, :destroy] do
    member do
      get :likes
      get :keeps
    end
  end
  resources :genres, only: [:index, :show] do
    resources :tags
  end
  resources :terms, except: [:new] do
    resources :descriptions, except: [:index] do
      resources :comments
      resource :like, only: [:create, :destroy]
    end
    resources :taggings, only: [:create, :destroy]
    resource :keep, only: [:create, :destroy]
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
