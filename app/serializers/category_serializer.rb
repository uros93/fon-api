class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :user
  has_many :rss_links
end
