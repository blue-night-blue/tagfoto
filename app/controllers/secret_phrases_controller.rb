class SecretPhrasesController < ApplicationController
  before_action :set_secret_phrase, only: %i[ show edit update destroy ]

  def create
    @secret_phrase = SecretPhrase.new(secret_phrase_params)
    @secret_phrase.user_id=@current_user.id

    respond_to do |format|
      if @secret_phrase.save
        format.html { redirect_to setting_path, flash:{success:"登録しました。"}}
      else
        format.html { redirect_to setting_path, notice: "空白です" }
      end
    end
  end

  def update
    respond_to do |format|
      if @secret_phrase.update(secret_phrase_params)
        format.html { redirect_to setting_path, flash:{success:"更新しました。"}}
      else
        format.html { redirect_to setting_path, notice: "空白です" }
      end
    end
  end

  
  
  
  
  
  

  def authenticated
    @user=User.find(params[:secret_phrase][:user_id])
    @approved_user = ApprovedUser.find_by(user_id:@user.id, approved_user_id:@current_user.id)
    @secret_phrase = SecretPhrase.find_by(user_id:@user.id) 
    
    if @secret_phrase.authenticate(params[:secret_phrase][:password])
      @approved_user.authenticated = true
      @approved_user.save
      flash[:success]="合言葉が一致しました"
      redirect_to request.referer
    else
      flash[:notice]="合言葉が違います"
      redirect_to request.referer
    end
  end
  
  
  
  
  
  
  

  private
    def set_secret_phrase
      @secret_phrase = SecretPhrase.find(params[:id])
    end

    def secret_phrase_params
      params.require(:secret_phrase).permit(:user_id, :password)
    end
end
