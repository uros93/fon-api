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
			expect(json_data[0]['attributes']['image']).not_to be_empty
			expect(json_data[0]['relationships']).not_to be_empty
			expect(json_data[0]['relationships']['website']['data']['type']).to eq 'websites'
			expect(json_data[0]['relationships']['website']['data']['id'].to_i).to eq website_id
		end

		it "returns status 200" do
			expect(response.status).to eq 200
		end

		context "when link doesnt have image" do
			let!(:rss_link) {create(:rss_link, website: website, link: "http://www.blic.rs/rss/danasnje-vesti")}
			it "returns json" do
				expect(json_data[0]['attributes']['title']).not_to be_empty
				expect(json_data[0]['attributes']['link']).not_to be_empty
				expect(json_data[0]['attributes']['description']).not_to be_empty
				expect(json_data[0]['attributes']['image']).to be nil
				expect(json_data[0]['relationships']['website']['data']['type']).to eq 'websites'
				expect(json_data[0]['relationships']['website']['data']['id'].to_i).to eq website_id
			end

			it "returns status 200" do
				expect(response.status).to eq 200
			end
		end
	end

	context "when request is invalid" do
		context "when website id is invalid" do 
			let(:website_id) {-1}
			it "returns status 404" do
				expect(response.status).to eq 404
			end
		end


		context "when rss_link id is invalid" do 
			let(:rss_link_id) {-1}
			it "returns status 404" do
				expect(response.status).to eq 404
			end
		end

		context "when headers are invalid" do 
			let(:headers) {invalid_headers}
			it "returns status 422" do
				expect(response.status).to eq 422
			end
		end
	end
end