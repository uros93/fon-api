require 'rails_helper'

RSpec.describe 'GET /websites/:website_id/rss_links' do 
	let!(:user) {create(:user)}
	let!(:website) {create(:website, user: user)}
	let!(:rss_links) {create_list(:rss_link, 10, website: website)}
	let(:headers) { valid_headers(user) }
	let(:website_id) {website.id}

	before { get "/websites/#{website_id}/rss_links", params: {}, headers: headers }

	context "when request is valid" do 
		it "returns status 200" do
			expect(response.status).to eq(200)
		end

		it "returns json" do
			expect(json_data.size).to eq 10
			expect(json_data.map {|j| j['id'].to_i}).to eq rss_links.pluck(:id)
			expect(json_included_relationship_attribute('name')).to eq website.name
		end
	end

	context "when request is invalid" do
		context "when website_id is invalid" do
			let(:website_id) {-1}
			it "returns status 404" do
				expect(response.status).to eq 404
			end
		end
		context "when headers are invlaid" do
			let(:headers) {invalid_headers}
			it "returns status 401" do 
			 	expect(response.status).to eq 401
			end
		end
	end
end