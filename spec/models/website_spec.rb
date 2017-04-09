require 'rails_helper'

RSpec.describe Website, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_length_of(:name).is_at_most(50)}
  it {should validate_length_of(:description).is_at_most(300)}
  it {should belong_to(:user) }
  it {should have_many(:rss_links)}
  it {should allow_values("http://rts.rs","https://rts.rs").for(:url)}
  it {should_not allow_values("random thing", "random http thing").for(:url) }
end
