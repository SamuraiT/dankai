json.merge! like.attributes.except('user_id', 'post_id')
json.user do
  json.partial! partial: 'users/user', locals: {user: like.user}
end
