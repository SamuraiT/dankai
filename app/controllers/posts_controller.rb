class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: :show

  # GET /posts
  def index
    @posts = Post
      .subscribed_by_user(current_user)
      .page(params[:page])
      .ordered
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  # GET /posts/1
  def show
    render 'show', formats: 'json', handlers: 'jbuilder'
  end

  # POST /posts
  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:body)
  end
end
