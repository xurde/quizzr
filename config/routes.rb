ActionController::Routing::Routes.draw do |map|

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  
  map.signup '/users/signup', :controller => 'users', :action => 'new'
  map.login  '/users/login', :controller => 'sessions', :action => 'new'
  map.logout '/users/logout', :controller => 'sessions', :action => 'destroy'  
  
  map.resources :users
  map.resource :session

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.  
  

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect ':user', :controller => 'users', :action => 'show'
  map.connect ':user/quizzs/:id', :controller => 'quizzs', :action => 'show'
  map.connect '/responses/:id', :controller => 'responses', :action => 'create'  
  
  
end
