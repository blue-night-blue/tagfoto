class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i[ edit update destroy ]
  before_action :set_post, only: %i[ edit update destroy ]

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to yourphoto_path
    end
  end 
  

  
  
  
  
  
  def new
    @post = Post.new
    @taggroups=Taggroup.where(user_id:@current_user.id).order(:sort_order)
    @tags =Tag.where(user_id:@current_user.id).order(:sort_order)
    @multiple_images=true
  end

  def create
    if params[:post][:images] 

      # 複数画像を個別ポストで保存
      params[:post][:images].each do |image|
        @post = Post.new(post_params)
        @post.user_id=@current_user.id
        @post.images=image_resize(image)
        
        # 読点をカンマに変換し、末尾がカンマでない場合にカンマを追加
        converted_tag_string = @post.tag.gsub("、", ",")
        if converted_tag_string[-1] != ","
          converted_tag_string += ","
        end
        @post.tag = converted_tag_string
        
        unless @post.save 
          redirect_to upload_path
          return
        end
      end

      # 未登録のタグを登録
      if @post.tag != ""
        tags_in_tags_hash = Tag.tags_in_tags(@current_user)
        tags_not_included_in_model = @post.tag.to_s.split(",").reject { |tag| tags_in_tags_hash[tag] }
        tags_not_included_in_model.each do |tag|
          Tag.create(user_id: @current_user.id , tag: "#{tag}" , group: "")
        end
      end
      flash[:success]="アップロードしました。"
      redirect_to yourphoto_path
    else
      redirect_to upload_path
    end
  end

  def update
    
    if image=params[:post][:images]
      @post.images=image_resize(image)
    end

    @post.update(post_params)

    # 読点をカンマに変換し、末尾がカンマでない場合にカンマを追加
    converted_tag_string = @post.tag.gsub("、", ",")
    if converted_tag_string[-1] != ","
      converted_tag_string += ","
    end
    @post.tag = converted_tag_string
    
    unless @post.save 
      redirect_to request.referer
      return
    end

    # 未登録のタグを登録
    if @post.tag != ""
      tags_in_tags_hash = Tag.tags_in_tags(@current_user)
      tags_not_included_in_model = @post.tag.to_s.split(",").reject { |tag| tags_in_tags_hash[tag] }
      tags_not_included_in_model.each do |tag|
        Tag.create(user_id: @current_user.id , tag: "#{tag}" , group: "")
      end
    end

    flash[:success]="更新しました。"
    redirect_to yourphoto_path
  end

  def destroy
    @post.destroy
    
    respond_to do |format|
      format.html { redirect_to yourphoto_path, flash:{success:"削除しました。"} }
    end
  end

  def edit
    if params[:tag]
      @posts = Post.where(user_id:@current_user.id).where("tag LIKE ?","%#{params[:tag]}%")
    elsif params[:view]=="all"
      @posts = Post.where(user_id:@current_user.id)
    elsif params[:view]=="nothing_tag"
      @posts = Post.where(user_id:@current_user.id).where(tag:"")
    else
      flash[:notice]="無効なURLです。"
      redirect_to yourphoto_path  
      return
    end

    current_index = @posts.index(@post)
    @recent_photo_post = @posts[current_index + 1] if current_index < @posts.length - 1
    @old_photo_post = @posts[current_index - 1] if current_index > 0
    
    @taggroups=Taggroup.where(user_id:@current_user.id).order(:sort_order)
    @tags =Tag.where(user_id:@current_user.id).order(:sort_order)
    
  end


  
  
  
  
  
  
  
  
  
  # 自分の写真
  
  def yourphoto
    tags_in_posts_array = Post.tags_in_posts(@current_user)
    tags_in_tags_hash = Tag.tags_in_tags(@current_user)
    @tags_included_in_model=Tag.where(user_id:@current_user.id).where(tag: tags_in_posts_array).order(:sort_order)
    @tags_not_included_in_model = tags_in_posts_array.reject { |tag| tags_in_tags_hash[tag] }

    groups_in_tags_in_posts_array = @tags_included_in_model.pluck(:group).reject(&:empty?)
    @taggroups=Taggroup.where(user_id:@current_user.id).where(id:groups_in_tags_in_posts_array).order(:sort_order)

    @posts = Post.where(user_id:@current_user.id).limit(3).order(created_at: :desc)
  end

  def yourphoto_all
    @posts = Post.where(user_id:@current_user.id).order(created_at: :desc)
  end

  def yourphoto_tag
    @posts = Post.where(user_id:@current_user.id).where("tag LIKE ?","%#{params[:tag]}%").order(created_at: :desc)
  end

  def yourphoto_nothing_tag
    @posts = Post.where(user_id:@current_user.id).where(tag:"").order(created_at: :desc)
  end

  
  
  
  
  
  

  # 閲覧を許可された写真
  
  def sharedphoto
    @approved_users=ApprovedUser.where(approved_user_id:@current_user.id)
  end

  def approved_index
    @user=User.find_by(name:params[:user_name])
    @approved_user = ApprovedUser.find_by(user_id:@user.id, approved_user_id:@current_user.id)
    if  @user.present? && @approved_user.present?

      tags_in_posts_array = Post.tags_in_posts(@user)
      tags_in_tags_hash = Tag.tags_in_tags(@user)
      @tags_included_in_model=Tag.where(user_id:@user.id).where(tag: tags_in_posts_array).order(:sort_order)
      @tags_not_included_in_model = tags_in_posts_array.reject { |tag| tags_in_tags_hash[tag] }

      groups_in_tags_in_posts_array = @tags_included_in_model.pluck(:group).reject(&:empty?)
      @taggroups=Taggroup.where(user_id:@user.id).where(id:groups_in_tags_in_posts_array).order(:sort_order)

      @posts = Post.where(user_id:@user.id).limit(3).order(created_at: :desc) 
      
      @secret_phrase = SecretPhrase.find_by(user_id:@user.id) 
    else
      flash[:notice]="当該のユーザーが存在しない、もしくは権限がありません"
      redirect_to yourphoto_path
    end
  end

  def approved_photo_all
    @user=User.find_by(name:params[:user_name])
    if  @user && ApprovedUser.find_by(user_id:@user.id, approved_user_id:@current_user.id).present?
      @posts = Post.where(user_id:@user.id).order(created_at: :desc)
    else
      flash[:notice]="当該のユーザーが存在しない、もしくは権限がありません"
      redirect_to yourphoto_path
    end
  end

  def approved_photo_tag
    @user=User.find_by(name:params[:user_name])
    if  @user && ApprovedUser.find_by(user_id:@user.id, approved_user_id:@current_user.id).present?
      @posts = Post.where(user_id:@user.id).where("tag LIKE ?","%#{params[:tag]}%").order(created_at: :desc)
    else
      flash[:notice]="当該のユーザーが存在しない、もしくは権限がありません"
      redirect_to yourphoto_path
    end
  end

  def approved_nothing_tag
    @user=User.find_by(name:params[:user_name])
    if  @user && ApprovedUser.find_by(user_id:@user.id, approved_user_id:@current_user.id).present?
      @posts = Post.where(user_id:@user.id).where(tag:"").order(created_at: :desc)
    else
      flash[:notice]="当該のユーザーが存在しない、もしくは権限がありません"
      redirect_to yourphoto_path
    end
  end

  def approved_show
    @user=User.find_by(name:params[:user_name])

    if  @user && ApprovedUser.find_by(user_id:@user.id, approved_user_id:@current_user.id).present?

      @post = Post.find(params[:id])
      
      # 前後ポストへのナビゲーション用
      if params[:tag]
        @posts = Post.where(user_id:@user.id).where("tag LIKE ?","%#{params[:tag]}%")
      elsif params[:view]=="all"
        @posts = Post.where(user_id:@user.id)
      elsif params[:view]=="nothing_tag"
        @posts = Post.where(user_id:@user.id).where(tag:"")
      else
        flash[:notice]="無効なURLです。"
        redirect_to approved_index_path 
        return
      end

      current_index = @posts.index(@post)
      @recent_photo_post = @posts[current_index + 1] if current_index < @posts.length - 1
      @old_photo_post = @posts[current_index - 1] if current_index > 0
        

      # タグ表示用 
      tags_in_posts_array = @post.tag.split(",").map(&:strip).reject(&:empty?) 
      tags_in_tags_hash = Tag.tags_in_tags(@user)
      @tags_included_in_model=Tag.where(user_id:@user.id).where(tag: tags_in_posts_array).order(:sort_order)
      @tags_not_included_in_model = tags_in_posts_array.reject { |tag| tags_in_tags_hash[tag] }

      groups_in_tags_in_posts_array = @tags_included_in_model.pluck(:group).reject(&:empty?)
      @taggroups=Taggroup.where(user_id:@user.id).where(id:groups_in_tags_in_posts_array).order(:sort_order)
      
    else
      flash[:notice]="当該のユーザーが存在しない、もしくは権限がありません"
      redirect_to yourphoto_path
    end
  end

 
  

  
  
  
  # 一括タグ付け 
  
  def tagto
    @posts = Post.where(user_id:@current_user.id).order(created_at: :desc)
    @taggroups=Taggroup.where(user_id:@current_user.id).order(:sort_order)
    @tags =Tag.where(user_id:@current_user.id).order(:sort_order)
  end

  def create_multiple_posts
    params[:post].each do |post_id, tag|
      post = Post.find_by(id: post_id)
      if post.tag != tag 
        post.update(tag: tag)
      end
    end
    redirect_to tagto_path 
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
