class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i[ show edit update destroy ]
  before_action :set_post, only: %i[ show edit update destroy ]

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to photo_path
    end
  end 
  
  
  def index
    @posts = Post.where(user_id:@current_user.id).order(created_at: :desc)
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
    @tags =Tag.where(user_id:@current_user.id).order(created_at: :desc)
  end

  def show
    @tags =Tag.where(user_id:@current_user.id).order(created_at: :desc)
  end
  
  def tagto
    @posts = Post.where(user_id:@current_user.id).order(created_at: :desc)
    @tags =Tag.where(user_id:@current_user.id).order(created_at: :desc)
  end

  def create_multiple_posts
    params[:post].each do |post_id, tag|
      post = Post.find_by(id: post_id)
      if post.tag != tag 
        post.update(tag: tag)
      end
    end
    redirect_to add_tag_path 
  end
   
  def approved_index
    user=User.find_by(name:params[:id])
    if  user && ApprovedUser.where(user_id:user.id, approved_user_id:@current_user.id).present?
      @posts = Post.where(user_id:user.id).order(created_at: :desc)
    else
      flash[:notice]="当該のユーザーが存在しない、もしくは権限がありません"
      redirect_to photo_path
    end
  end

  

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:comment, :tag)
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
