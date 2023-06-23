class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if @current_user.name==params[:id]
      @posts = Post.where(user_id:@current_user.id).order(created_at: :desc)
    else
      redirect_to root_path
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(image_resize(post_params))
    @post.user_id=@current_user.id

      if @post.save
        redirect_to post_url(@post), notice: "Post was successfully created." 
      else
        render :new, status: :unprocessable_entity 
      end

  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:comment, :image)
    end
    
    def image_resize(params)
      if params[:image]
        params[:image].tempfile = ImageProcessing::MiniMagick
          .source(params[:image].tempfile)
          .resize_to_limit(1024, 768)
          .strip
          .call
      end
      params
    end 
 
    
    
end
