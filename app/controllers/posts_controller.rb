class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_post, only: %i[show edit update destroy]

  def index
    author_id = params[:author_id]
    if author_id
      @posts = Post.where('author_id = ?', author_id).order('updated_at desc').page params[:page]
    else
      @posts = Post.all.order('updated_at desc').page params[:page]
    end
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def update
    if current_user.author?(@post)
      @post.update(post_params)
      redirect_to @post
    else
      redirect_to @post, alert: 'You is not author post'
    end
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Your post successfully created'
    else
      render :new
    end
  end

  def destroy
    if current_user.author?(@post)
      @post.destroy
      redirect_to root_path, notice: 'Your post successfully delete'
    else
      redirect_to @post, alert: 'You is not author post'
    end
  end

  private

  def load_post
    @post = Post.with_attached_images.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :author_id, images: [])
  end
end
