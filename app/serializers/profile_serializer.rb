class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  has_many :websites, :serializer => WebsiteSerializer
  has_many :categories, :serializer => CategorySerializer
end
