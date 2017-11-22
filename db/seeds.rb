require 'open-uri'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

YAML.load_file("#{Rails.root}/db/seeds/users.yml").deep_symbolize_keys[:users].each do |u|
  User.find_or_create_by(username: u[:username]) do |u|
    u.password = "dankai"
  end
end

User.limit(500).to_a.combination(2) do |a, b|
  Following.find_or_create_by(
    user_id: a.id,
    following_user_id: b.id
  )

  Following.find_or_create_by(
    user_id: b.id,
    following_user_id: a.id
  )
end

famous_users = YAML.load_file("#{Rails.root}/db/seeds/famous_users.yml").deep_symbolize_keys[:users]

famous_users.each do |famous_user|
  u1 = User.find_by(username: famous_user)
  User.all.each do |u2|
    Following.find_or_create_by(
      user_id: u2.id,
      following_user_id: u1.id
    )
  end
end

famous_user_ids = User.where(username: famous_users).pluck(:id)

YAML.load_file("#{Rails.root}/db/seeds/posts.yml").each do |post|
  p = Post.find_or_create_by(
    user_id: famous_user_ids.sample,
    body: post[:body],
  )
  Image.find_or_create_by(post_id: p.id, data: open(post[:original_image_url]).read)
end

words = YAML.load_file("#{Rails.root}/db/seeds/comments.yml")
users = User.limit(500).pluck(:id).to_a

Post.all.each do |post|
  10.times do
    Comment.create(post_id: post.id, body: words.sample, user_id: users.sample)
    Like.create(post_id: post.id, user_id: users.sample)
  end
end

icons = YAML.load_file("#{Rails.root}/db/seeds/icons.yml")

User.limit(500).each do |u|
  Icon.create(user_id: u.id, data: open(icons.sample).read)
end
