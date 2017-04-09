class ArticleSerializer < ActiveModel::Serializer
  attributes :title, :description, :link, :image
end
