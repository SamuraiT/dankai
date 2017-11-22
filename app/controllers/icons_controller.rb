class IconsController < ApplicationController
  before_action :authenticate_user, except: :show
  before_action :set_icon, only: [:show, :destroy]
  before_action :require_owner, only: [:destroy]

  def show
    if @icon
      send_data @icon.data, type: "image/png"
    else
      send_data Icon.default_icon_data, type: "image/png", disposition: "inline"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_icon
    @icon = Icon.find_by(user_id: params[:user_id])
  end

  def require_owner
    head(:forbidden) unless @icon.user == current_user
  end
end
