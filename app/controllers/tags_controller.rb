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
    @taggroups = Taggroup.where(user_id:@current_user.id).order(:sort_order).map { |group| [group.group, group.number] } 
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
    if @tag.update(tag_params) && @tag.saved_change_to_attribute?(:tag) || @tag.saved_change_to_attribute?(:group_number) || @tag.saved_change_to_attribute?(:sort_order)
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


  
 
  
  def export_tag_to_csv
    tags = Tag.where(user_id: @current_user)
    attributes = %w[tag sort_order group_number] 
    bom ="\xEF\xBB\xBF"
  
    csv_data = CSV.generate do |csv|
      csv << attributes
      tags.each do |tag|
        csv << tag.attributes.values_at(*attributes).map { |attr| attr.to_s }
      end
    end
  
    send_data bom + csv_data, filename: "tags.csv", type: "text/csv", disposition: "attachment"
  end
  
  def import_tag
    csv_file = params[:csv_file]
    csv_text = File.read(csv_file.path).encode('UTF-8', 'UTF-8', :invalid => :replace).sub(/^\xEF\xBB\xBF/, '')
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      tag_data = {
        user_id: @current_user.id,
        tag: row['tag'],
        sort_order: row['sort_order'],
        group_number: row['group_number'].to_s
      }

      if tag_data[:group_number].present? 
        taggroup = Taggroup.find_by(user_id: @current_user.id, number: tag_data[:group_number])
        if taggroup.number == tag_data[:group_number]
          Tag.create(tag_data)
        end
      else
        Tag.create(tag_data)
      end

    end
    redirect_to edittag_path

  end




  
  

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:user_id, :tag, :sort_order, :group_number)
    end
  end
