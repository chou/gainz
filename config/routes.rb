Lg::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users' }
  resource  :dashboard, only: [:show]
  resources :eat, only: [:index], controller: 'food_records'

  resources :users, only: [:update] do
    resources :food_records, except: [:index]
  end

  resource :account, only: [:edit, :show, :update]

  resource :home, only: :show
  root to: 'homes#show'
end
