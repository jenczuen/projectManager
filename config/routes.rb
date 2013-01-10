ProjectManager::Application.routes.draw do

  root :to => 'mainSite#index'

  match "/api/getCategories" => "categories#getCategories", :via => :get

end
