class CommentsController < ApplicationController
  before_action :load_post, only: %i[create destroy]

  def create
    @comment = @post.comments.create(comment_params)
    redirect_to @post
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(author_id: current_user.id)
  end

  def load_post
    @post = Post.find(params[:post_id])
  end
end
