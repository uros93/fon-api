require 'rails_helper'

RSpec.describe Category, type: :model do
  it {should belong_to(:user)}
  it {should validate_presence_of(:name)}
  it {should validate_length_of(:name).is_at_most(50)}
  it {should have_many(:rss_links).through(:category_links)} 
end
