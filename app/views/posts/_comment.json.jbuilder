json.merge! comment.attributes.except('user_id', 'post_id')
json.user do
  json.partial! partial: 'users/user', locals: {user: comment.user}
end
