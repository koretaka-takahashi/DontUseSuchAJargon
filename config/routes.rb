Rails.application.routes.draw do
  devise_for :users
  root "genres#index"
  resources :users, only: [:index, :show, :destroy] do
    member do
      get :likes
      get :keeps
    end
  end
  resources :genres, only: [:index, :show, :edit, :update] do
    resources :tags
  end
  resources :terms, except: [:new] do
    resources :descriptions, except: [:index] do
      resources :comments
      resource :like, only: [:create, :destroy] do
        collection do
          post :create2
          delete :destroy2
        end
      end
    end
    resources :taggings, only: [:create, :destroy]
    resource :keep, only: [:create, :destroy] do
      collection do
        post :create2
        delete :destroy2
      end
    end
  end
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
