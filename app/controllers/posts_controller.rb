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

  def create
    params[:post][:images].each do |image|

      image.tempfile = ImageProcessing::MiniMagick
      .source(image.tempfile)
      .resize_to_limit(1024, 768)
      .strip
      .call

      @post=Post.new(
        images:image,
        user_id: @current_user.id,
        comment:params[:post][:comment]
        )
      @post.save
    end
    redirect_to "/#{@current_user.name}"
  end
  
  # def create
  #   params[:post][:images].each do |image|
  #     @post=Post.new(
  #       images:image,
  #       user_id: @current_user.id,
  #       comment:params[:post][:comment]
  #       )
  #     @post.save
  #   end
  #   redirect_to "/#{@current_user.name}"
  # end
  
  # def create
  #   params[:post][:image].each do |image|
  #     @post = Post.new(post_params)
  #     @post.user_id=@current_user.id
  #       unless @post.save
  #         render :new, status: :unprocessable_entity 
  #       end
  #   end
  #   redirect_to "/#{@current_user.name}"
  # end

  # def create
  #   params[:post][:images].each do |image|
  #     @post=Post.new(images:image, user_id: @current_user.id)
  #     @post.save
  #   end
  #   redirect_to "/#{@current_user.name}"
  # end
  

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(image_resize(post_params))
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
      params.require(:post).permit(:comment, images: [])
    end
    
    def image_resize(params)
      params.tempfile = ImageProcessing::MiniMagick
        .source(params.tempfile)
        .resize_to_limit(1024, 768)
        .strip
        .call
      params
    end 
 
    
    
end
