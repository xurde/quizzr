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
  

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.password_recover '/password_recover', :controller => 'account', :action => 'password_recover'
  map.password_reset '/password_reset', :controller => 'account', :action => 'password_reset'
  
  
  map.resources :users
  map.resource :session

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.

  map.root :controller => "index"
  map.connect '/home', :controller => 'home'
  map.connect '/account/:action', :controller => 'account'
  map.connect '/quizzs/:action', :controller => 'quizzs'
  map.connect '/answer/:id', :controller => 'answers', :action => 'create'
  
  map.connect ':user', :controller => 'users', :action => 'show', :page => 1
  map.connect ':user/quizz/:id', :controller => 'quizzs', :action => 'show'
  map.connect ':user/answers', :controller => 'users', :action => 'show_answers', :page => 1
  map.connect ':user/:action', :controller => 'users'

  #default rails routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
