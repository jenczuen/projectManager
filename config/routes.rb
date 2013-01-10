ProjectManager::Application.routes.draw do

  root :to => 'mainSite#index'

  match "/api/getCategories" => "categories#getCategories", :via => :get
  match "/api/getUsers"      => "users#getUsers"          , :via => :get
  match "/api/getPosts"      => "posts#getPosts"          , :via => :get

end
