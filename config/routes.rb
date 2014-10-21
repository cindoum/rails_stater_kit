PlaygroundOnrails::Application.routes.draw do
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callback" }

    devise_scope :user do
        post 'login' => 'session#create', :as => 'login'
        delete 'logout' => 'session#destroy', :as => 'logout'
        get 'current_user' => 'session#show_current_user', :as => 'show_current_user'
        post 'register', to: 'registration#create', :as => 'register'
    end
    
    post '/error', to: 'error#create'
    
    get '/members', to: 'members#index'
    get '/members/:id', to: 'members#read'
    put '/members', to: 'members#update'
    post '/members', to: 'members#create'
    
    root to: "homes#index"
end
