class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]
  before_action :set_user, only: [:show, :followings, :followers]

  # GET /users/1
  def show
    render 'show', formats: 'json', handlers: 'jbuilder'
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users/1/followings
  def followings
    @followings = @user.followings.page(params[:page])
    render 'users/followings', formats: 'json', handlers: 'jbuilder'
  end

  # GET /users/1/followers
  def followers
    @followers = @user.followers.page(params[:page])
    render 'users/followers', formats: 'json', handlers: 'jbuilder'
  end

  # POST /users/1/follow
  def follow
    @following = Following.new(user_id: current_user.id, following_user_id: params[:id])

    if @following.save
      head(:created)
    else
      render json: @following.errors, status: :unprocessable_entity
    end
  end

  # POST /users/1/unfollow
  def unfollow
    Following.find(user_id: current_user.id, following_user_id: params[:id]).destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
