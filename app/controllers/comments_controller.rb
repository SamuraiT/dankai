class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: [:create]

  # POST /comments
  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user.id, post_id: @post.id))

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
