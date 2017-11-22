json.user do
  json.partial! @user
  json.following_count @user.followings_count
  json.followers_count @user.followers_count
end
