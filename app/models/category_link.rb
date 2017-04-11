class CategoryLink < ApplicationRecord
  belongs_to :category
  belongs_to :rss_link
end
