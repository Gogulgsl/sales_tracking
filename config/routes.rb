Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:index, :show, :create, :update, :destroy]
    resources :cities, only: [:index, :show, :create, :update, :destroy]
    resources :zones, only: [:index, :show, :create, :update, :destroy]
    resources :cities_users, only: [:index, :create, :destroy]
    resources :users_zones, only: [:index, :create, :destroy]
    resources :sales_teams
    resources :products
    resources :schools
    resources :institutes
    resources :opportunities
    post 'auth/login', to: 'auth#login'
    resources :opportunities do
      post :assign_sales_team, on: :member
    end
      resources :daily_statuses, only: [:index, :create, :show, :update, :destroy]

  end
end
