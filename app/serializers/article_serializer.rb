class ArticleSerializer < ActiveModel::Serializer
  attributes :title, :description, :link, :image
  belongs_to :website
end
