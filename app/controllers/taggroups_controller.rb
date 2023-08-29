class TaggroupsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i[ update destroy ]
  before_action :set_taggroup, only: %i[ update destroy ]
  
  def ensure_correct_user
    @taggroup = Taggroup.find_by(id: params[:id])
    if @taggroup.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to yourphoto_path
    end
  end 
  

  
  
  
  
  
  def index
    @taggroup = Taggroup.new
    @search = Taggroup.where(user_id:@current_user.id).ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @taggroups = @search.result.page(params[:page])
  end

  def new
    @taggroup = Taggroup.new
  end

  def create
    @taggroup = Taggroup.new(taggroup_params)
    taggroup_name = @taggroup.group
    @taggroup.user_id=@current_user.id

    if @taggroup.save
      respond_to do |format|
          format.html { redirect_to tags_path, notice: "#{taggroup_name}を投稿しました" }
          format.turbo_stream { flash.now.notice = "#{taggroup_name}を投稿しました" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    taggroup_name = @taggroup.group
    if @taggroup.update(taggroup_params) && @taggroup.saved_change_to_attribute?(:group) || @taggroup.saved_change_to_attribute?(:sort_order)
      respond_to do |format|
        if @taggroup.update(taggroup_params)
          format.html { redirect_to taggroups_path, notice: "#{taggroup_name}を修正しました" }
          format.turbo_stream { flash.now[:notice] = "#{taggroup_name}を修正しました" }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    taggroup_name = @taggroup.group
    tags = Tag.where(user_id:@current_user.id, group:@taggroup.id.to_s)
    tags.each do |tag|
      tag.group = ""
      tag.save
    end
    @taggroup.destroy
  
    respond_to do |format|
      format.html { redirect_to taggroups_path, notice: "#{taggroup_name}を削除しました" }
      format.turbo_stream { flash.now[:notice] = "#{taggroup_name}を削除しました" }
    end
  end














 private
    def set_taggroup
      @taggroup = Taggroup.find(params[:id])
    end

    def taggroup_params
      params.require(:taggroup).permit(:group, :sort_order, :user_id)
    end
end
