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
  get "/yourphoto/" , to: "posts#yourphoto" , trailing_slash: true 
  get "/sharedphoto" , to: "posts#sharedphoto"
  get "/tagto" , to: "posts#tagto"  
  get "/edittag" , to: "tags#index"  
  get "/setting" , to: "users#setting"  

  # 自分の写真
  get "yourphoto/tag/:tag/" , to: "posts#yourphoto_tag"  , trailing_slash: true
  get "yourphoto/tag/:tag/:id" , to: "posts#edit"  

  get "yourphoto/all/" , to: "posts#yourphoto_all" , trailing_slash: true 
  get "yourphoto/nothing_tag/" , to: "posts#yourphoto_nothing_tag"  , trailing_slash: true
  get "yourphoto/:view/:id" , to: "posts#edit"  

  # 閲覧を許可された写真
  get "/photo/:user_name/tag/:tag/" , to: "posts#approved_photo_tag" , trailing_slash: true  
  get "/photo/:user_name/tag/:tag/:id" , to: "posts#approved_show"

  get "/photo/:user_name/" , to: "posts#approved_index" , as: :approved_index , trailing_slash: true  
  get "/photo/:user_name/all/" , to: "posts#approved_photo_all" , as: :approved_photo_all , trailing_slash: true 
  get "/photo/:user_name/nothing_tag/" , to: "posts#approved_nothing_tag" , as: :approved_nothing_tag , trailing_slash: true 
  get "/photo/:user_name/:view/:id" , to: "posts#approved_show"  
  
  post "/authenticated" , to: "secret_phrases#authenticated"  
 
  # その他 
  post "/create_multiple_posts" , to: "posts#create_multiple_posts"  
  get "/edittaggroup" , to: "taggroups#index"  
  post "/secret_message_access_toggle/:user_id" , to: "approved_users#secret_message_access_toggle"  


  
  # resources
  resources :users, only: %i[ update ]
  resources :secret_phrases, only: %i[ create update ]
  resources :approved_users, only: %i[ create destroy ]
  
  resources :posts, only: %i[ new create update destroy ]

  resources :tags, only: %i[ create update destroy index ]
  resources :taggroups, only: %i[ create update destroy index ]
  



end
