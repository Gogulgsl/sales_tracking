Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:index, :show, :create, :update, :destroy]
    resources :cities, only: [:index, :show, :create, :update, :destroy]
    resources :zones, only: [:index, :show, :create, :update, :destroy]
    resources :cities_users, only: [:index, :create, :destroy]
    resources :users_zones, only: [:index, :create, :destroy]
    resources :sales_teams
    resources :products
    resources :schools do
      collection do
        post :upload
      end
    end
    resources :institutes
    resources :opportunities do
      collection do
        post :add_opportunities, to: 'opportunities#create'
        get :my_opportunities
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
    resources :master_data, except: [:create]
    post 'add_master_data', to: 'master_data#create'
    resources :daily_statuses
    resources :contacts
    resources :stages
  end
end
