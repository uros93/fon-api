class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :websites, :serializer => WebsiteSerializer
end
