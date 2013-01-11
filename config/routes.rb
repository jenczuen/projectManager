ProjectManager::Application.routes.draw do

  root :to => 'mainSite#index'

  match "/api/users/create"    => "users#create"        , :via => :post
  match "/api/users/update"    => "users#update"        , :via => :post
  match "/api/users/destroy"    => "users#destroy"        , :via => :post
  match "/api/users/get"      => "users#get"          , :via => :get
  match "/api/users/all"     => "users#all"          , :via => :get

  match "/api/categories/create"    => "categories#create"        , :via => :post
  match "/api/categories/update"    => "categories#update"        , :via => :post
  match "/api/categories/destroy"    => "categories#destroy"        , :via => :post
  match "/api/categories/get"      => "categories#get"          , :via => :get
  match "/api/categories/all"     => "categories#all"          , :via => :get


  match "/api/getPosts"      => "posts#getPosts"          , :via => :get

end
