class Icon < ApplicationRecord
  belongs_to :user

  def self.default_icon_data
    File.read("#{Rails.root}/db/seeds/icons/default.png")
  end
end
