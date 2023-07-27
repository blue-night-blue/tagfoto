class TaggroupsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i[ show edit update destroy ]
  before_action :set_taggroup, only: %i[ show edit update destroy ]
  
  def ensure_correct_user
    @taggroup = Taggroup.find_by(id: params[:id])
    if @taggroup.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to photo_path
    end
  end 
  
  # GET /taggroups or /taggroups.json
  def index
    @taggroup = Taggroup.new
    @search = Taggroup.where(user_id:@current_user.id).ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @taggroups = @search.result.page(params[:page])
  end

  # GET /taggroups/1 or /taggroups/1.json
  def show
  end

  # GET /taggroups/new
  def new
    @taggroup = Taggroup.new
  end

  # GET /taggroups/1/edit
  def edit
  end

  # POST /taggroups or /taggroups.json
  def create
    @taggroup = Taggroup.new(taggroup_params)
    @taggroup.user_id=@current_user.id

    respond_to do |format|
      if @taggroup.save
        format.html { redirect_to taggroups_url, notice: "Taggroup was successfully created." }
        format.json { render :show, status: :created, location: @taggroup }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @taggroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taggroups/1 or /taggroups/1.json
  def update
    respond_to do |format|
      if @taggroup.update(taggroup_params)
        format.html { redirect_to taggroups_url, notice: "Taggroup was successfully updated." }
        format.json { render :show, status: :ok, location: @taggroup }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @taggroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taggroups/1 or /taggroups/1.json
  def destroy
    @taggroup.destroy

    respond_to do |format|
      format.html { redirect_to taggroups_url, notice: "Taggroup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taggroup
      @taggroup = Taggroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def taggroup_params
      params.require(:taggroup).permit(:group, :sort_order, :user_id)
    end
end
