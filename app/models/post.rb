class Post < ApplicationRecord
  belongs_to :user

  has_one :image, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :ordered, -> { order(created_at: :desc) }
  scope :subscribed_by_user, -> (user) {
    joins("INNER JOIN `followings` ON `posts`.`user_id` = `followings`.`following_user_id`").
    where(
      followings: {
        user_id: user.id
      }
    )
  }

  def likes_count
    likes.count
  end

  def comments_count
    comments.count
  end

  def subscribe_likes_by_following_users(user)
    following_user_ids = user.followings_within_oneself.pluck(:following_user_id)
    Like.
      joins(:post).
      where(
        user_id: following_user_ids,
        post_id: self.id
      )
  end

  def is_liked_by_user(user)
    self.likes.exists?(user_id: user.id)
  end
end
