json.pagination do
  json.total_pages @latest_posts.total_pages
  json.next_page @latest_posts.next_page
  json.prev_page @latest_posts.prev_page
  json.current_page @latest_posts.current_page
end
json.posts do
  json.array! @latest_posts do |post|
    json.partial! partial: 'posts/post', locals: {post: post}
  end
end
