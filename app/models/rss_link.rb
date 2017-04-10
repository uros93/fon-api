class RssLink < ApplicationRecord
	include ActiveModel::Validations

  belongs_to :website
  validates_length_of :name, maximum: 50
  validates_length_of :description, maximum: 300
  validates_presence_of :link
  validates_with RssLinkValidator, fields: [:link]
end
