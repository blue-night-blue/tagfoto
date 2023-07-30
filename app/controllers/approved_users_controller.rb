class ApprovedUsersController < ApplicationController
  before_action :set_approved_user, only: %i[ destroy ]

  def index
    @approved_user= ApprovedUser.new
    @approved_users = ApprovedUser.where(user_id: @current_user.id)
  end

  def new
    @approved_user = ApprovedUser.new
  end

  def create
    user_name=params[:approved_user][:user_name]
    user=User.find_by(name:user_name)
    if user.present?

      if user.id==@current_user.id
        redirect_to editapproveduser_path, notice: "自身を登録することはできません。"
        return 
      end 
      
      @approved_user = ApprovedUser.new
      @approved_user.approved_user_id=user.id
      @approved_user.user_id=@current_user.id
      
      respond_to do |format|
        if @approved_user.save
          format.html { redirect_to editapproveduser_path, notice: "Approved user was successfully created." }
          format.json { render :show, status: :created, location: @approved_user }
        else
          format.html { redirect_to editapproveduser_path, notice: "既に追加済みです。" }
          format.json { render json: @approved_user.errors, status: :unprocessable_entity }
        end
      end

    else
      flash[:notice]="ユーザー名が間違っています"
      redirect_to editapproveduser_path
    end
  end

  def destroy
    @approved_user.destroy

    respond_to do |format|
      format.html { redirect_to editapproveduser_path, notice: "Approved user was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_approved_user
      @approved_user = ApprovedUser.find(params[:id])
    end

    def approved_user_params
      params.require(:approved_user).permit(:user_id, :approved_user_id, :authenticated, :user_name)
    end
end
