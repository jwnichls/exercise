Iborg::Application.routes.draw do

  root to: 'static_pages#home'

  # Campaigns
  
  resources :campaigns

  # Posts

  resources :posts, :except => [:destroy] do
    member do
      get "vote_up"
      get "vote_down"
      get :unpost, :as => "unpost"
      get :disable, :as => "disable"
    end
  end
  
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
