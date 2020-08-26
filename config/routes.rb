Rails.application.routes.draw do
  devise_for :users
  root "users#show" # ←仮です
  resources :users, only: [:show]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
