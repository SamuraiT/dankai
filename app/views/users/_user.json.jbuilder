json.merge! user.attributes.except('password_digest')
json.icon_url user_icon_url(user)
if @_current_user
  json.is_following user.is_following_by_user(@_current_user)
end
