class ApprovedUsersController < ApplicationController
  before_action :set_approved_user, only: %i[ destroy ]

  
  
  
  

  def create
    user_name=params[:approved_user][:user_name]
    user=User.find_by(name:user_name)
    if user.present?

      if user.id==@current_user.id
        redirect_to setting_path, notice: "自身を登録することはできません。"
        return 
      end 
      
      @approved_user = ApprovedUser.new
      @approved_user.approved_user_id=user.id
      @approved_user.user_id=@current_user.id
      
      respond_to do |format|
        if @approved_user.save
          format.html { redirect_to setting_path, flash:{success:"登録しました。"} }
        else
          format.html { redirect_to setting_path, notice: "既に追加済みです。" }
        end
      end

    else
      flash[:notice]="ユーザー名が間違っています"
      redirect_to setting_path
    end
  end

  def destroy
    @approved_user.destroy

    respond_to do |format|
      format.html { redirect_to setting_path, flash:{success:"削除しました。"} }
    end
  end

  
  
  
  
  
  def secret_message_access_toggle
    @approved_user = ApprovedUser.find_by(user_id: @current_user.id,approved_user_id:params[:user_id].to_i)
    @secret_phrase = SecretPhrase.find_by(user_id:@current_user.id) 
    if @secret_phrase.present?
      if @approved_user.secret_message_access==nil
        @approved_user.secret_message_access=true
        @approved_user.save
      else  
        @approved_user.secret_message_access=nil
        @approved_user.save
      end
    end
    redirect_to setting_path
  end
  
  
  
  
  
  
  

  private
    def set_approved_user
      @approved_user = ApprovedUser.find(params[:id])
    end

    def approved_user_params
      params.require(:approved_user).permit(:user_id, :approved_user_id, :authenticated, :user_name)
    end
end
