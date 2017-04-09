class Website < ApplicationRecord
  belongs_to :user
  has_many :rss_links
  validates_presence_of :name
  validates_length_of :name, maximum: 50
  validates_length_of :description, maximum: 300
  validates :url, :url => true
end
