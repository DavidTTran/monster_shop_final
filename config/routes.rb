Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :root, to: 'welcome#index'

  # resources :merchants do
  #   resources :items, only: [:index]
  # end
  get '/merchants', to: 'merchants#index'
  get '/merchants/:id', to: 'merchants#show'
  get '/merchants', to: 'merchants#create'
  post '/merchants', to: 'merchants#add'
  delete '/merchants/:id', to: 'merchants#destroy'
  get '/merchants/:id', to: 'merchants#edit'
  put '/merchants/:id', to: 'merchants#update'
  get '/merchants/:id/items', to: 'merchant_items#index'

  # resources :items, only: [:index, :show] do
  #   resources :reviews, only: [:new, :create]
  # end
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/items/:id/reviews', to: 'reviews#new'
  post '/items/:id/reviews', to: 'reviews#create'

  # resources :reviews, only: [:edit, :update, :destroy]
  get '/reviews/:id', to: 'reviews#edit'
  put '/reviews/:id', to: 'reviews#update'
  delete '/reviews/:id', to: 'reviews#destroy'

  # get '/cart', to: 'cart#show'
  # post '/cart/:item_id', to: 'cart#add_item'
  # delete '/cart', to: 'cart#empty'
  # patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  # delete '/cart/:item_id', to: 'cart#remove_item'
  scope :cart do
    get '/', to: 'cart#show'
    delete '/', to: 'cart#empty'
    resources :item, controller: :cart, only: [:none] do
      post 'add_item'
      patch 'update_quantity'
      delete 'remove_item'
    end
  end

  get '/registration', to: 'users#new', as: :registration
  # resources :users, only: [:create, :update]

  patch '/user/:id', to: 'users#update'
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/edit_password', to: 'users#edit_password'
  post '/orders', to: 'user/orders#create'

  # get '/profile/orders', to: 'user/orders#index'
  # get '/profile/orders/:id', to: 'user/orders#show'
  # delete '/profile/orders/:id', to: 'user/orders#cancel'
  scope :profile do
    resources :orders, controller: 'user/orders', only: [:index, :show, :destroy] do
      delete 'cancel'
    end
  end

  # get '/login', to: 'sessions#new'
  # post '/login', to: 'sessions#login'
  # get '/logout', to: 'sessions#logout'
  resources :login, controller: :sessions, only: [:new, :post] do
    post 'login'
  end

  namespace :merchant do
    get '/', to: 'dashboard#index', as: :dashboard
    # resources :orders, only: :show
    # resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    get '/orders/:id', to: 'orders#show'
    get '/items', to: 'items#index'
    get '/items', to: 'items#new'
    post '/items', to: 'items#create'
    get '/items/:id', to: 'items#edit'
    patch '/items/:id', to: 'items#update'
    delete '/items/:id', to: 'items#destroy'

    put '/items/:id/change_status', to: 'items#change_status'
    get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'
  end

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    # resources :merchants, only: [:show, :update]
    # resources :users, only: [:index, :show]
    get '/merchants/:id', to: 'merchants#show'
    patch '/merchants/:id', to: 'merchants#update'
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'

    patch '/orders/:id/ship', to: 'orders#ship'
  end
end
