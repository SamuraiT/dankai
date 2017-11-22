class ImagesController < ApplicationController
  before_action :authenticate_user, except: :show
  before_action :set_post, only: :create
  before_action :set_image, only: :show
  before_action :require_owner, only: :create

  def show
    if @image
      send_data @image.data
    else
      head(:not_found)
    end
  end

  def create
    data = ImageConverterClient.convert(request.raw_post)

    @image = Image.new(post_id: @post.id, data: data)

    if @image.save
      head(:created)
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_image
    @image = Image.find_by(post_id: params[:post_id])
  end

  def require_owner
    head(:forbidden) unless @post.user == current_user
  end
end
