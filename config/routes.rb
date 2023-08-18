Rails.application.routes.draw do
  
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

  # 自分の写真
  get "/photo_all" , to: "posts#photo_all"  
  get "/photo_tag/:tag" , to: "posts#photo_tag"  
  get "/nothing_tag" , to: "posts#nothing_tag"  

  # 閲覧を許可された写真
  get "/sharedphoto" , to: "posts#sharedphoto"  
  get "/photo/:user_name" , to: "posts#approved_index"  
  get "/photo/:user_name/all/" , to: "posts#approved_photo_all"  
  get "/photo/:user_name/tag/:tag" , to: "posts#approved_photo_tag"  
  get "/photo/:user_name/nothing_tag/" , to: "posts#approved_nothing_tag"  
  get "/photo/:user_name/show/:id" , to: "posts#approved_show"  
  post "/authenticated" , to: "secret_phrases#authenticated"  
 
  # その他 
  post "/create_multiple_posts" , to: "posts#create_multiple_posts"  
  get "/edittaggroup" , to: "taggroups#index"  
  post "/secret_message_access_toggle/:user_id" , to: "approved_users#secret_message_access_toggle"  


  
  # resources
  resources :users, only: %i[ update ]
  resources :secret_phrases, only: %i[ create update ]
  resources :approved_users, only: %i[ create destroy ]
  
  resources :posts, only: %i[ new create update destroy edit ]

  resources :tags, only: %i[ create update destroy index ]
  resources :taggroups, only: %i[ create update destroy index ]
  



end
