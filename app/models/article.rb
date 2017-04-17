class Article < ActiveModelSerializers::Model
  attributes :id, :title, :description, :link, :image, :website, :category_tags
end