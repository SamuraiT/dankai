json.pagination do
  json.total_pages @posts.total_pages
  json.next_page @posts.next_page
  json.prev_page @posts.prev_page
  json.current_page @posts.current_page
end
json.posts do
  json.array! @posts do |post|
    json.partial! post
  end
end
