json.merge! post.attributes
json.image_url post_image_url(post)
json.user do
  json.partial! partial: 'users/user', locals: {user: post.user}
end
json.comments do
  json.array! post.comments.limit(5).ordered do |comment|
    json.partial! partial: 'posts/comment', locals: {comment: comment}
  end
end
json.likes do
  json.array! post.likes.limit(5).ordered do |like|
    json.partial! partial: 'posts/like', locals: {like: like}
  end
end
json.comments_count post.comments_count
json.likes_count post.likes_count
if @_current_user
  json.is_liked post.is_liked_by_user(@_current_user)
end
