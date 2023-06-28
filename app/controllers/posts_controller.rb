class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    if @current_user.name==params[:id]
      @posts = Post.where(user_id:@current_user.id).order(created_at: :desc)
    else
      redirect_to root_path
    end
  end

  def new
    @post = Post.new
  end

  def create
    if params[:post][:images] 
      params[:post][:images].each do |image|
        @post = Post.new(post_params)
        @post.user_id=@current_user.id
        @post.images=image_resize(image)
        @post.save
      end
      redirect_to "/#{@current_user.name}"
    else
      redirect_to :new_post
    end
  end

  def update
    if image=params[:post][:images]
      @post.images=image_resize(image)
    end
    @post.update(post_params)
    @post.save
    redirect_to "/#{@current_user.name}"
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def edit
  end

  def show
  end
  
  
  
  

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:comment)
    end
    
    def image_resize(image)
      image.tempfile = ImageProcessing::MiniMagick
        .source(image.tempfile)
        .resize_to_limit(1024, 768)
        .strip
        .call
      image
    end 
 
    
    
end
