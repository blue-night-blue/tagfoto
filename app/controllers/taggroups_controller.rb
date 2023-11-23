class TaggroupsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i[ update destroy ]
  before_action :set_taggroup, only: %i[ update destroy ]
  before_action :set_next_number, only: [:create]
  require 'csv'

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
    @taggroup.number = @next_number

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
    tags = Tag.where(user_id:@current_user.id, group_number:@taggroup.number)
    tags.each do |tag|
      tag.group_number = nil
      tag.save
    end
    @taggroup.destroy
  
    respond_to do |format|
      format.html { redirect_to taggroups_path, notice: "#{taggroup_name}を削除しました" }
      format.turbo_stream { flash.now[:notice] = "#{taggroup_name}を削除しました" }
    end
  end






  def export_taggroup_to_csv
    taggroups = Taggroup.where(user_id: @current_user)
    attributes = %w[group sort_order number] 
    bom ="\xEF\xBB\xBF"
  
    csv_data = CSV.generate do |csv|
      csv << attributes
      taggroups.each do |taggroup|
        csv << taggroup.attributes.values_at(*attributes).map { |attr| attr.to_s }
      end
    end
  
    send_data bom + csv_data, filename: "taggroups.csv", type: "text/csv", disposition: "attachment"
  end
  

  def import_taggroup
    csv_file = params[:csv_file]
    csv_text = File.read(csv_file.path).encode('UTF-8', 'UTF-8', :invalid => :replace).sub(/^\xEF\xBB\xBF/, '')
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      taggroup_data = {
        user_id: @current_user.id,
        group: row['group'],
        sort_order: row['sort_order'],
        number: row['number'].to_s
      }

      unless Taggroup.exists?(user_id: @current_user.id, number: taggroup_data[:number])
        Taggroup.create(taggroup_data)
      end
    end

    redirect_to edittaggroup_path
  end









 private
    def set_taggroup
      @taggroup = Taggroup.find(params[:id])
    end

    def taggroup_params
      params.require(:taggroup).permit(:group, :sort_order, :user_id)
    end

    def set_next_number
      last_taggroup = Taggroup.where(user_id: @current_user.id).order(number: :desc).first
      @next_number = last_taggroup.present? ? last_taggroup.number.to_i + 1 : 1
    end

end
