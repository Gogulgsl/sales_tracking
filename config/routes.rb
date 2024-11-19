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
    resources :opportunities do
      collection do
        get :my_opportunities
      end
      member do
        post :assign_sales_team
      end
    end
    resources :auth, only: [] do
      collection do
        post :login
      end
    end    
    resources :daily_statuses do 
      collection do
        get :my_daily_statuses
      end
    end
  end
end
