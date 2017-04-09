require 'rails_helper'

RSpec.describe RssLink, type: :model do
  it {should validate_presence_of(:link)}
  it {should validate_length_of(:name).is_at_most(50)}
  it {should validate_length_of(:description).is_at_most(300)}
  it {should belong_to(:website) }
  # it {should allow_values("http://www.rts.rs/page/stories/sr/rss.html","http://www.blic.rs/rss/danasnje-vesti").for(:link)}
  # it {should_not allow_values("random thing", "random http thing", "http://www.rts.rs").for(:link) }
end
