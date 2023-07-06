Rails.application.routes.draw do
  resources :tags
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "top#top"
  get "/top" , to: redirect('../')
  get "/signup" , to: "users#signup_form"  
  post "/signup" , to: "users#signup"  
  get "/login" , to: "users#login_form"  
  post "/login" , to: "users#login"  
  post "/logout" , to: "users#logout"  
  
  get "/index2" , to: "posts#index2"  
  get "/:id" , to: "posts#index"  
  
  

end
