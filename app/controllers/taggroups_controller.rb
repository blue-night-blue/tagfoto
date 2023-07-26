class TaggroupsController < ApplicationController
  before_action :set_taggroup, only: %i[ show edit update destroy ]

  # GET /taggroups or /taggroups.json
  def index
    @taggroups = Taggroup.all
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

    respond_to do |format|
      if @taggroup.save
        format.html { redirect_to taggroup_url(@taggroup), notice: "Taggroup was successfully created." }
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
        format.html { redirect_to taggroup_url(@taggroup), notice: "Taggroup was successfully updated." }
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