class PostsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  before_action :load_post, only: %i[show destroy]

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

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Your post successfully created'
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Your post successfully delete'
  end

  private

  def load_post
    @post = Post.with_attached_images.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :author_id, images: [])
  end
end
