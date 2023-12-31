Rails.application.routes.draw do
  
  # トップおよびサインイン/アウト/退会 
  root "top#top"
  get "/top" , to: redirect('../')
  get "/signup" , to: "users#signup_form"  
  post "/signup" , to: "users#signup"  
  get "/login" , to: "users#login_form"  
  post "/login" , to: "users#login"  
  post "/logout" , to: "users#logout"  
  get "/leave_service" , to: "users#leave_service_form"  
  post "/leave_service" , to: "users#leave_service"  
  
  # メニューバー用 
  get "/upload" , to: "posts#new"  
  get "/yourphoto/" , to: "posts#yourphoto" , trailing_slash: true 
  get "/sharedphoto" , to: "posts#sharedphoto"
  get "/tagto" , to: "posts#tagto"  
  get "/edittag" , to: "tags#index"  
  get "/setting" , to: "users#setting"  

  # フッター用 
  get "/about" , to: "top#about"
  get "/updates" , to: "top#updates"
  get "/contact" , to: "top#contact"

  # 自分の写真
  get "/yourphoto/tagsearch/results/:id" , to: "posts#edit"
  get "/yourphoto/tagsearch/" , to: "posts#yourphoto_tagsearch"  , trailing_slash: true
  get "/yourphoto/tagsearch/results" , to: "posts#yourphoto_tagsearch_results"  , trailing_slash: true

  get "yourphoto/tag/:tag/" , to: "posts#yourphoto_tag"  , trailing_slash: true
  get "yourphoto/tag/:tag/:id" , to: "posts#edit"  

  get "yourphoto/all/" , to: "posts#yourphoto_all" , trailing_slash: true 
  get "yourphoto/nothing_tag/" , to: "posts#yourphoto_nothing_tag"  , trailing_slash: true
  get "yourphoto/:view/:id" , to: "posts#edit"  

  get "/yourphoto/select_and_delete" , to: "posts#select_and_delete" ,as: :select_and_delete
  post "/multiple_delete" , to: "posts#multiple_delete"  

  # 閲覧を許可された写真
  get "/photo/:user_name/tagsearch/results/:id" , to: "posts#approved_show"
  get "/photo/:user_name/tagsearch/" , to: "posts#approved_photo_tagsearch", as: :approved_photo_tagsearch   , trailing_slash: true
  get "/photo/:user_name/tagsearch/results" , to: "posts#approved_photo_tagsearch_results", as: :approved_photo_tagsearch_results   , trailing_slash: true

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
  get "/export_tag_to_csv" , to: "tags#export_tag_to_csv"  
  get "/export_taggroup_to_csv" , to: "taggroups#export_taggroup_to_csv"  
  post "/import_taggroup" , to: "taggroups#import_taggroup"  
  post "/import_tag" , to: "tags#import_tag"  


  
  # resources
  resources :users, only: %i[ update ]
  resources :secret_phrases, only: %i[ create update ]
  resources :approved_users, only: %i[ create destroy ]
  
  resources :posts, only: %i[ new create update destroy ]

  resources :tags, only: %i[ new create update destroy index edit ]
  resources :taggroups, only: %i[ new create update destroy index edit ]
  



end
