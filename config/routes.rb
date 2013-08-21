Iborg::Application.routes.draw do

  root to: 'static_pages#home'

  # Campaigns
  
  resources :campaigns

  # Posts

  get "posts", :to => "posts#index", :as => "index"
  resource "posts"
  get "posts/unpost", :to => "posts#unpost", :as => "unpost" 
  get "posts/disable", :to => "posts#disable", :as => "disable"

  #match "surveyresponses/new", :to => "surveyresponses#create"
  #get 'surveyresponses/new'
  resources :posts do
    resources :votes
    #resources :surveyresponses
  end
  
  # Votes
  
  get 'votes/create'
  
  # Surveys

  resource :surveys



  # Authentication

  get '/auth/failure', :to => 'session#failure'
  get '/auth/twitter/callback', :to => 'sessions#create'
  get '/auth/persona/callback', :to => 'sessions#create'

  # Sessions
  
  get '/sessions/create'
  get '/sessions/failure'
  get '/sessions/destroy', :as => :logout

  # Admin Features
  
  resources :admins, :only => [:index] do
    collection do
      get :export
    end
  end

  # Tweets

  resources :tweets, :only => [:new] do
    collection do
      get :follow
      get :create_and_post
      get :tweet
    end
  end

  # Users
  
  get "users/show"

  # Static Pages
    
  get "static_pages/home"
  get "static_pages/help"

end
