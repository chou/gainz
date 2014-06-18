Lg::Application.routes.draw do
  devise_for :users
  resources :dashboards, only: [:index]

  resource :home, only: :show
  root to: 'homes#show'
end
