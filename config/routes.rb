ProjectManager::Application.routes.draw do

  root to: 'mainSite#index'

  match '/signin',                  to: 'sessions#new'
  match '/signout',                 to: 'sessions#destroy',     via: :post

  match "/api/users/create",        to: "users#create",         via: :post
  match "/api/users/update",        to: "users#update",         via: :post
  match "/api/users/destroy",       to: "users#destroy",        via: :post
  match "/api/users/get",           to: "users#get",            via: :get
  match "/api/users/all",           to: "users#all",            via: :get

  match "/api/categories/create",   to: "categories#create",    via: :post
  match "/api/categories/update",   to: "categories#update",    via: :post
  match "/api/categories/destroy",  to: "categories#destroy",   via: :post
  match "/api/categories/get",      to: "categories#get",       via: :get
  match "/api/categories/all",      to: "categories#all",       via: :get

  match "/api/getPosts",            to: "posts#getPosts",       via: :get

end
