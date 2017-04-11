class Category < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: {maximum: 50}
  has_many :category_links, :dependent => :destroy
  has_many :rss_links, through: :category_links
end
