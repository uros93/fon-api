class ArticleSerializer < ActiveModel::Serializer
  attributes :title, :description, :link, :image, :category_tags
  belongs_to :website
end
