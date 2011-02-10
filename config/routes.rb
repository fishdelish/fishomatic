Fishomatic::Application.routes.draw do
  match "/auth/:provider/callback" => "authentications#create"
  match "/auth/failure" => "authentications#failure"
  devise_for :users, :controllers => {:sessions => "user/sessions"} do
    post "/users/link_account" => "user/sessions#link_account", :as => "link_account"
  end
  resources :authentications do
    collection do
      get :unknown
      post :create_account
    end
  end

  root :to => "fish_files#index"
  
  put "/fish_files" => "fish_files#update" 
  get "/fish_files" => "fish_files#index", :as => "fish_files"

  scope "/fish_files" do
    get "display" => "fish_files#display"
    get "file" => "fish_files#get_file", :as => "fish_files_file"
    put "file" => "fish_files#upload"
    get "file/edit" => "fish_files#edit_file", :as => "fish_files_edit_file"
    get "edit" => "fish_files#edit", :as => "fish_files_edit"
    get ":username" => "fish_files#show", :as => "fish_files_user"
    get ":username/file" => "fish_files#get_file", :as => "fish_files_user_file"
  end

  get 'fish_location/:id' => 'fish_files#file_location', :as => "external_fish_file"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
