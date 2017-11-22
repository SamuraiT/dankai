json.array! @followers do |user|
  json.partial! partial: 'users/user', locals: {user: user}
end
