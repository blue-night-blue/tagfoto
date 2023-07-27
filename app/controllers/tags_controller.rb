class TagsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i[ show edit update destroy ]
  before_action :set_tag, only: %i[ show edit update destroy ]
  
  def ensure_correct_user
    @tag = Tag.find_by(id: params[:id])
    if @tag.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to photo_path
    end
  end 
  
  
  # GET /tags or /tags.json
  def index
    @tag = Tag.new
    @search = Tag.where(user_id:@current_user.id).ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @tags = @search.result.page(params[:page])

    @taggroups = Taggroup.where(user_id:@current_user.id).order(:sort_order).map { |group| [group.group, group.id] } 
  end 

  # GET /tags/1 or /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)
    @tag.user_id=@current_user.id

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_url, notice: "Tag was successfully created." }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to tags_url, notice: "Tag was successfully updated." }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url, notice: "Tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:user_id, :tag, :sort_order, :group)
    end
end
