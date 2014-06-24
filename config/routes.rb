Lg::Application.routes.draw do
  devise_for :users
  resources :dashboards, only: [:index]
  resources :users, only: [:update]

  resource :home, only: :show
  root to: 'homes#show'
end
