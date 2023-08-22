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

  def create
    @taggroup = Taggroup.new(taggroup_params)
    @taggroup.user_id=@current_user.id

    respond_to do |format|
      if @taggroup.save
        format.html { redirect_to taggroups_url }
      else
        format.html { redirect_to taggroups_url }
      end
    end
  end

  def update
    respond_to do |format|
      if @taggroup.update(taggroup_params)
        format.html { redirect_to taggroups_url}
      else
        format.html { redirect_to taggroups_url }
      end
    end
  end

  def destroy
    @taggroup.destroy

    respond_to do |format|
      format.html { redirect_to taggroups_url}
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
