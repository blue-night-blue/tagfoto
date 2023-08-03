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
  get "/photo" , to: "posts#photo"  
  get "/tagto" , to: "posts#tagto"  
  get "/edittag" , to: "tags#index"  
  get "/setting" , to: "users#setting"  

  # その他 
  post "/create_multiple_posts" , to: "posts#create_multiple_posts"  
  get "/edittaggroup" , to: "taggroups#index"  
  get "/sharedphoto" , to: "posts#sharedphoto"  
  get "/photo/:user_name" , to: "posts#approved_index"  
  get "/photo/:user_name/all/" , to: "posts#approved_photo_all"  
  get "/photo/:user_name/nothing_tag/" , to: "posts#approved_nothing_tag"  
  get "/photo/:user_name/tag/:tag" , to: "posts#approved_photo_tag"  
  get "/photo/:user_name/show/:id" , to: "posts#approved_show"  
  post "/authenticated" , to: "secret_phrases#authenticated"  
  get "/photo_all" , to: "posts#photo_all"  
  get "/photo_tag/:tag" , to: "posts#photo_tag"  
  get "/nothing_tag" , to: "posts#nothing_tag"  
  post "/secret_message_access_toggle/:user_id" , to: "approved_users#secret_message_access_toggle"  

  resources :taggroups
  resources :tags
  resources :posts
  resources :users
  resources :approved_users, only: %i[index new create destroy]
  

end
