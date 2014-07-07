Lg::Application.routes.draw do
  devise_for :users
  resource :dashboard, only: [:show]
  resources :users, only: [:update]

  resource :account, only: [:edit, :show, :update]

  resource :home, only: :show
  root to: 'homes#show'
end
