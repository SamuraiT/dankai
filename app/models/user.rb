class User < ApplicationRecord
  has_secure_password

  has_one :icon, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followings_within_oneself, class_name: 'Following', dependent: :destroy
  has_many :followers_within_oneself, class_name: 'Following', foreign_key: :following_user_id, dependent: :destroy
  has_many :followings_within_oneself_users, through: :followings_within_oneself, source: 'target_user'

  after_create :follow_oneself

  validates :username, uniqueness: true

  def self.from_token_request(request)
    self.find_by(username: request.params["auth"] && request.params["auth"]["username"])
  end

  def to_token_payload
    {sub: id, username: username}
  end

  def followings
    user_ids = followings_within_oneself.without_oneself.ordered.pluck(:following_user_id)
    User.where(id: user_ids)
  end

  def followers
    user_ids = followers_within_oneself.without_oneself.ordered.pluck(:user_id)
    User.where(id: user_ids)
  end

  def followings_count
    followings.count
  end

  def followers_count
    followers.count
  end

  def is_following_by_user(user)
    self.followers_within_oneself.pluck(:user_id).include?(user.id)
  end

  private
  def follow_oneself
    self.followings_within_oneself.find_or_create_by!(target_user: self)
  end
end
