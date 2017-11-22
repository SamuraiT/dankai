class LatestPostsController < ApplicationController
  def index
    @latest_posts = Post
      .page(params[:page])
      .order(created_at: :desc)
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
