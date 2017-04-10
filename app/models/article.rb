class Article < ActiveModelSerializers::Model
  attributes :id, :title, :description, :link, :image, :website
end