class LocationConstraints
  def matches?(request) 
     return false if request.fullpath.starts_with? "/admin"
     true
  end
end

Arcfolio::Application.routes.draw do  
  match "/favorites" => "favorite#index"
  get "favorite/index"
  get "favorite/add"
  get "favorite/remove"
  get "favorite/clear"
  match "/favorites/:id" => "favorite#index"
  match "/signup/upgrade" => "page#signup_upgrade"
  match "/signup/publish" => "page#signup_publish"
  match "/account/created" => "page#account_created"

  devise_for :users
  resources :works

#  resources :image
#  get "image/edit"
  
  get "users/listing"
  post "users/listing_update"

  match "/account/listing" => "users#listing"

  get "subscriptions/index"
  get "subscriptions/confirm"
  get "subscriptions/cancel"
  get "subscriptions/error"
  get "subscriptions/checkout"
  get "subscriptions/process_payment"
  get "users/listing"

  get "page/image_upload"
  post "page/image_upload"
  get "page/test"

  match "account" => "page#account"

  
  match "/" => "page#show_all"
  match "cities" => "page#cities"
  match "/about" => "page#about"
  get "page/about"
  get "page/home"
  get "page/cities"
  get "page/listing"
  get "page/signup"
  match "/signup" => "page#signup"
  match "/listing/:id" => "page#listing"
  match "/listing/:id/print" => "page#listing_print"
  root :to => "page#home"
  match 'users/work_images/:id' => 'users#work_images' 
  get "users/work_images"

  match 'works/images/:id' => 'works#images'
  get "works/images"

  get "page/country_cities"
  get "page/state_cities"
  match "/by_city/:id" => "page#by_city"
  match "/by_country_and_city/:country/:city" => "page#by_country_and_city"
  match "/by_country/:name" => "page#by_country"
  get "page/by_country"
  get "page/by_city"
  get "page/by_city_name"
  get "page/catalog"
  get "page/show_all"
  get "page/by_budget"
  match "/:location" => "page#catalog", :constraints => LocationConstraints.new
  match "/:location/:budget" => "page#catalog", :constraints => LocationConstraints.new

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
