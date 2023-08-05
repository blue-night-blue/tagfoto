class ApplicationController < ActionController::Base

    before_action :set_current_user
  
    # 以下、上から順に第n関門です
    
    def authenticate_user
        if @current_user == nil
          flash[:notice] = "ログインが必要です"
          redirect_to("/login")
        end
    end    
    
    def forbid_login_user
        if @current_user
          flash[:notice] = "すでにログインしています"
          redirect_to photo_path
        end
    end 

    def set_current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    
   
end
