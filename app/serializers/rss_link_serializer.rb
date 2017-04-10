class RssLinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :link
  belongs_to :website
end
