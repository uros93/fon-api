require 'rails_helper'

RSpec.describe 'GET /websites/:id/articles' do 
	let!(:user) {create(:user)}
	let!(:website) {create(:website, user: user)}
	let(:headers) { valid_headers(user) }
	let(:website_id) {website.id}
	before { 
		website.rss_links << create(:rss_link, link: "http://www.blic.rs/rss/Vesti/Svet" , website: website)
		website.rss_links << create(:rss_link, link: "http://www.rts.rs/page/stories/sr/rss/10/svet.html" , website: website)
		website.rss_links << create(:rss_link, link: "http://www.b92.net/info/rss/sport.xml" , website: website)
		get "/websites/#{website_id}/articles", params: {}, headers: headers
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
			expect(json_data[0]['relationships']).not_to be_empty
			expect(json_data[0]['relationships']['website']['data']['type']).to eq 'websites'
			expect(json_data[0]['relationships']['website']['data']['id'].to_i).to eq website_id
		end
	end

	context "when request is invalid" do
		context "when headers are invalid" do 
			let(:headers){invalid_headers}
			it "return status 401" do
				expect(response.status).to eq 401
			end
		end

		context "when website is invalid" do
			let(:website_id) {-1}
			it "returns status 404" do
				expect(response.status).to eq 404
			end
		end
	end

	context "when website doesnt have any rss links" do
		let!(:other_website) {create(:website, user: user)}
		before { get "/websites/#{other_website.id}/articles", params: {}, headers: headers}

		it "returns status 204" do
			expect(response.status).to eq 204
		end

		it "returns empty json" do
			expect(response.body).to be_empty
		end
	end
end