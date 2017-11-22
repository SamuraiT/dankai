class LikesController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: [:create]

  # POST /likes
  def create
    @like = Like.new(user_id: current_user.id, post_id: @post.id)

    if @like.save
      render json: @like, status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end
end
