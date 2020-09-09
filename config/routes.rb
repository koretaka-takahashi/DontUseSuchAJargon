Rails.application.routes.draw do
  devise_for :users
  root "genres#index"
  resources :users, only: [:index, :show]
  resources :genres, only: [:index, :show] do
    resources :tags
  end
  resources :terms do
    resources :descriptions, except: [:index]
    resources :taggings, only: [:new, :create, :destroy]
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
