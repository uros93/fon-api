require 'rails_helper'

RSpec.describe 'GET /websites/:website_id/rss_links/:id' do 
	let!(:user) {create(:user)}
	let!(:website) {create(:website, user: user)}
	let!(:rss_link) {create(:rss_link, website: website)}
	let(:headers) { valid_headers(user) }
	let(:rss_link_id) {rss_link.id}
	let(:website_id) {rss_link.website.id}
	before { get "/websites/#{website_id}/rss_links/#{rss_link_id}", params: {}, headers: headers}

	context "when request is valid" do
		it "returns json" do
			expect(json_data).not_to be_empty
			expect(json_data.size).to be > 1
			expect(json_data[0]['attributes']['title']).not_to be_empty
			expect(json_data[0]['attributes']['link']).not_to be_empty
			expect(json_data[0]['attributes']['description']).not_to be_empty
		end

		it "returns status 200" do
			expect(response.status).to eq 200
		end
	end
end