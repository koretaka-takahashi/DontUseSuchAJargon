Rails.application.routes.draw do
  devise_for :users
  root "genres#index"
  resources :users, only: [:index, :show]
  resources :genres, only: [:index, :show] do
    resources :tags
  end
  resources :terms, except: [:new] do
    resources :descriptions, except: [:index] do
      resources :comments
    end
    resources :taggings
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
