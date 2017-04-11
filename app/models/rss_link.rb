class RssLink < ApplicationRecord
	include ActiveModel::Validations

  belongs_to :website
  validates_length_of :name, maximum: 50
  validates_length_of :description, maximum: 300
  validates_presence_of :link
  validates_with RssLinkValidator, fields: [:link]
  has_many :category_links, :dependent => :destroy
  has_many :categories, through: :category_links
end
