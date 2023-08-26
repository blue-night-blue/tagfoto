class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[ update destroy ] 
  before_action :forbid_login_user, only: %i[ signup_form signup login_form login ]
  before_action :ensure_correct_user, only: %i[ update destroy ]
  before_action :set_user, only: %i[ update destroy ]
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to yourphoto_path
    end
  end 

  
  
  
  
  
  
  
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to setting_path, flash:{success:"更新しました。"} }
      else
        format.html { render :setting, status: :unprocessable_entity }
      end
    end
  end


  
  
  
  
  
  

  def signup_form
    @user=User.new
  end

  def signup
    @user=User.new(user_params)
    
    if @user.save
      session[:user_id]=@user.id
      flash[:success]="ユーザー登録しました。" 
      redirect_to root_path
    else
      render :signup_form,status: :unprocessable_entity 
    end
  end
  
  def login_form
    @user=User.new
  end
  
 def login
    @login_user=User.new(user_params)
    @user=User.find_by(email:@login_user.email)

    if @user && @user.authenticate(@login_user.password)
      session[:user_id]=@user.id
      flash[:success]="ログインしました。" 
      redirect_to root_path
    else
      flash[:notice]="メール・パスワードのいずれか、もしくは両方が間違っています。" 
      render :login_form,status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
    flash[:success]="ログアウトしました。" 
  end

  def setting
    @user=User.find(@current_user.id)
    @approved_user= ApprovedUser.new
    @approved_users = ApprovedUser.where(user_id: @current_user.id)
    
    @secret_phrase = SecretPhrase.find_by(user_id:@current_user.id) 
    if @secret_phrase.present?
      @present="登録済み"
    else
      @secret_phrase = SecretPhrase.new
      @present="未登録"
    end
    
    @find_secret_phrase = SecretPhrase.find_by(user_id:@current_user.id) 
    
  end

  def leave_service
  end
  
 def leave_service
    if @current_user.authenticate(params[:password])
      session[:user_id]=nil
      flash[:success]="退会しました。" 
      redirect_to root_path
    else
      flash[:notice]="パスワードが間違っています。" 
      redirect_to leave_service_path
    end
  end

 

  
  
  
  

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :approved_users, :secret_message)
    end
end
