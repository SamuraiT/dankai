class InitializeController < ApplicationController
  def do
    Comment.where("id > 582774").delete_all
    Following.where("id > 276810").delete_all
    Icon.where("id > 500").delete_all
    Image.where("id > 24095").delete_all
    Like.where("id > 582777").delete_all
    Post.where("id > 23812").delete_all
    User.where("id > 5862").delete_all

    head(:ok)
  end
end
