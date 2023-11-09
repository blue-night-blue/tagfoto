class TagsController < ApplicationController
  before_action :authenticate_user
  before_action :set_my_taggroup
  before_action :set_tag, only: %i[ edit update destroy ]
  before_action :ensure_correct_user, only: %i[ edit update destroy ]
  
  def ensure_correct_user
    if @tag.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to edittag_path
    end
  end 
  
  def set_my_taggroup
    @taggroups = Taggroup.where(user_id:@current_user.id).order(:sort_order).map { |group| [group.group, group.id] } 
  end 


  
  
  
  
  
  
  def index
    @tag = Tag.new
    @search = Tag.where(user_id:@current_user.id).ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @tags = @search.result
  end 

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    tag_name = @tag.tag
    @tag.user_id=@current_user.id

    if @tag.save
      respond_to do |format|
        format.html { redirect_to tags_path, notice: "#{tag_name}を投稿しました" }
        format.turbo_stream { flash.now.notice = "#{tag_name}を投稿しました" }
      end
    else
      render :new, status: :unprocessable_entity
    end

  end

  def update
    tag_name = @tag.tag
    if @tag.update(tag_params) && @tag.saved_change_to_attribute?(:tag) || @tag.saved_change_to_attribute?(:group) || @tag.saved_change_to_attribute?(:sort_order)
      respond_to do |format|
        if @tag.update(tag_params)
          format.html { redirect_to tags_path, notice: "#{tag_name}を修正しました" }
          format.turbo_stream { flash.now[:notice] = "#{tag_name}を修正しました" }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    tag_name = @tag.tag
    @tag.destroy
  
    respond_to do |format|
      format.html { redirect_to tags_path, notice: "#{tag_name}を削除しました" }
      format.turbo_stream { flash.now[:notice] = "#{tag_name}を削除しました" }
    end
  end


  
  
  
  

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:user_id, :tag, :sort_order, :group)
    end
  end
