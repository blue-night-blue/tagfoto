class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[ index show edit update destroy ] 
  before_action :forbid_login_user, only: %i[ signup_form signup login_form login ]
  before_action :ensure_correct_user, only: %i[ index show edit update destroy ]
  before_action :set_user, only: %i[ show edit update destroy ]
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to photo_path
    end
  end 
  
  
  
  
  # GET /users or /users.json
  def index
  end

  # GET /users/1 or /users/1.json
  def show
  end


  # GET /users/1/edit
  def edit
  end

  def signup_form
    @user=User.new
  end

  def signup
    @name=params[:@name]
    @email=params[:@email]
    @password=params[:@password]
    @user = User.new(
      name:@name,
      email:@email,
      password:@password
    )
    
    if @user.save
      session[:user_id]=@user.id
      redirect_to root_path,notice:"ok" 
    else
      render :signup_form,status: :unprocessable_entity 
    end
  end
  
  def login_form
  end
  
 def login
    @email=params[:@email]
    @password=params[:@password]
    @user=User.find_by(email:@email)

    if @user && @user.authenticate(@password)
      session[:user_id]=@user.id
      redirect_to root_path,notice:"ok" 
    else
      @error="メールかパスワードがどっちか分かりませんが間違えとります"
      render :login_form,status: :unprocessable_entity
    end

  end

  def logout
    session[:user_id] = nil
    redirect_to root_path,notice:"ok" 
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), flash:{success:"更新しました。"} }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
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
    
  end


 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :approved_users)
    end
end
