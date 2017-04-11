require 'rails_helper'

RSpec.describe RssLink, type: :model do
  it {should validate_presence_of(:link)}
  it {should validate_length_of(:name).is_at_most(50)}
  it {should validate_length_of(:description).is_at_most(300)}
  it {should belong_to(:website) }
  it {should allow_values("http://www.rts.rs/page/stories/sr/rss.html","http://www.blic.rs/rss/danasnje-vesti").for(:link)}
  it {should_not allow_values("random thing", "random http thing", "http://www.rts.rs").for(:link) }
  it {should have_many(:categories).through(:category_links)}

  context "when there are categories in it" do 
  	let(:with_categories) {create(:rss_link_with_categories)}
  	it "should be more than 0 categories" do
  		expect(with_categories.categories.size).to be > 0
  	end
  end
end
