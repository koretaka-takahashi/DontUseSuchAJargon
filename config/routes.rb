Rails.application.routes.draw do
  devise_for :users
  root "users#index" # ←仮です
  resources :users, only: [:index, :show]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
