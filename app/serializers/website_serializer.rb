class WebsiteSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :url
  belongs_to :user
end
