Rails.application.routes.draw do
  resources :secret_phrases
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
  get "/setting" , to: "users#setting"  

  # その他 
  post "/create_multiple_posts" , to: "posts#create_multiple_posts"  
  get "/edittaggroup" , to: "taggroups#index"  
  get "/editapproveduser" , to: "approved_users#index"  
  get "/sharedphoto" , to: "posts#sharedphoto"  
  get "/photo/:user_name" , to: "posts#approved_index"  
  get "/photo/:user_name/:id" , to: "posts#approved_show"  
  post "/authenticated" , to: "secret_phrases#authenticated"  
  

  resources :taggroups
  resources :tags
  resources :posts
  resources :users
  resources :approved_users, only: %i[index new create destroy]
  

end
