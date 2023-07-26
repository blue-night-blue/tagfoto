Rails.application.routes.draw do
  resources :tags
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # トップおよびサインイン/アウト 
  root "top#top"
  get "/top" , to: redirect('../')
  get "/signup" , to: "users#signup_form"  
  post "/signup" , to: "users#signup"  
  get "/login" , to: "users#login_form"  
  post "/login" , to: "users#login"  
  post "/logout" , to: "users#logout"  
  
  # メニューバー用 
  get "/upload" , to: "posts#new"  
  get "/photo" , to: "posts#index"  
  get "/tagto" , to: "posts#tagto"  
  get "/edittag" , to: "tags#index"  

  
  # その他 
  post "/create_multiple_posts" , to: "posts#create_multiple_posts"  
  
  

end
