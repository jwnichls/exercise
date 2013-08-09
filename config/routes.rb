Iborg::Application.routes.draw do
  root to: 'static_pages#home'
  resource :surveys

  get '/login', :to => 'sessions#new', :as => :login
  
  get '/auth/failure', :to => 'session#failure'
  #match '/auth/twitter/callback', :to => 'sessions#create'
  get '/auth/twitter/callback', :to => 'sessions#create'
  get '/auth/persona/callback', :to => 'sessions#create'
  get '/admin', :to => 'admins#index'
  get '/admin/export', :to => 'admins#export'

  get "tweets/new"
  get "tweets/follow"
  get "tweets/create_and_post"
  #get "tweets/retweet"
  get "sessions/new"

  get "sessions/create"

  get "sessions/failure"

  get "sessions/destroy"

  get "posts", :to => "posts#index", :as => "index"
  resource "posts"
  get "posts/unpost", :to => "posts#unpost", :as => "unpost" 
  get "posts/disable", :to => "posts#disable", :as => "disable"

  get "users/show"
  get 'votes/create'
  get "tweets/tweet"
  
  get "static_pages/home"
  get "static_pages/help"

  #match "surveyresponses/new", :to => "surveyresponses#create"
  #get 'surveyresponses/new'
  resources :posts do
    resources :votes
    #resources :surveyresponses
  end
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
