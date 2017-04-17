require 'rails_helper'

RSpec.describe 'GET /category/:id/articles' do
	let!(:user) {create(:user)} 
	let!(:category) {create(:category, user: user)}
	let(:headers) { valid_headers(user) }
	let(:category_id) {category.id}

	before { 
		category.rss_links << create(:rss_link, link: "http://www.blic.rs/rss/Vesti/Svet" , website: create(:website, user: user))
		category.rss_links << create(:rss_link, link: "http://www.rts.rs/page/stories/sr/rss/10/svet.html", website: create(:website, user: user))
		category.rss_links << create(:rss_link, link: "http://www.b92.net/info/rss/sport.xml", website: create(:website, user: user))
		get "/categories/#{category_id}/articles", params: {}, headers: headers
	}

	context "when request is valid" do
		it "returns status 200" do
			expect(response.status).to eq 200
		end

		it "returns json" do
			parsed_links = parsed_link("http://www.blic.rs/rss/Vesti/Svet") + parsed_link("http://www.rts.rs/page/stories/sr/rss/10/svet.html") + parsed_link("http://www.b92.net/info/rss/sport.xml")
			expect(json_data).not_to be_empty
			expect(json_data.size).to eq parsed_links.size
			expect(json_data[0]['attributes']['title']).not_to be_empty
			expect(json_data[0]['attributes']['link']).not_to be_empty
			expect(json_data[0]['attributes']['description']).not_to be_empty
			expect(json_data[0]['attributes']['category-tags']).to include category.name.downcase
			expect(json_data[0]['relationships']).not_to be_empty
			expect(json_data[0]['relationships']['website']['data']['type']).to eq 'websites'
		end
	end
end