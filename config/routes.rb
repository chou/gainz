Lg::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users' }
  resource :dashboard, only: [:show]
  resources :users, only: [:update] do
    resources :eat, controller: 'food_records'

    resources :food_records
  end

  resource :account, only: [:edit, :show, :update]

  resource :home, only: :show
  root to: 'homes#show'
end
