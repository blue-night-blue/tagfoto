class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

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
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
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



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
