class TagsController < ApplicationController
  before_action :authenticate_user
  before_action :set_tag, only: %i[ update destroy ]
  before_action :ensure_correct_user, only: %i[ update destroy ]
  
  def ensure_correct_user
    if @tag.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to edittag_path
    end
  end 
  

  
  
  
  
  
  
  def index
    @tag = Tag.new
    @search = Tag.where(user_id:@current_user.id).ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @tags = @search.result.page(params[:page])

    @taggroups = Taggroup.where(user_id:@current_user.id).order(:sort_order).map { |group| [group.group, group.id] } 
  end 

  def create
    @tag = Tag.new(tag_params)
    @tag.user_id=@current_user.id

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_url}
      else
        format.html { redirect_to edittag_path}
      end
    end
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to tags_url}
      else
        format.html { redirect_to edittag_path}
      end
    end
  end

  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url}
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
