require 'rails_helper'

RSpec.describe 'PUT /websites/:website_id/rss_links/:id' do 
	let!(:user) {create(:user)}
	let!(:website) {create(:website, user: user)}
	let!(:rss_link) {create(:rss_link, website: website)}
	let(:headers) { valid_headers(user) }
	let(:rss_link_id) {rss_link.id}
	let(:website_id) {rss_link.website.id}
	let(:valid_attributes){{name: "Some other name", link: "http://www.blic.rs/rss/danasnje-vesti"}.to_json}
	before { put "/websites/#{website_id}/rss_links/#{rss_link_id}", params: valid_attributes, headers: headers}

	context "when request is valid" do
		it "returns status code 202" do
			expect(response.status).to eq 202
		end

		it "returns json" do
			expect(json_attributes('name')).to eq "Some other name"
			expect(json_attributes('description')).to eq rss_link.description
			expect(json_attributes('link')).to eq "http://www.blic.rs/rss/danasnje-vesti"
			expect(json_included_relationship_attribute('name')).to eq website.name
			expect(json_relationship_id('website')).to eq website.id
		end
	end

	context "when request is invalid" do
		context "when attributes are invalid" do 
			let(:valid_attributes) {{link:"http://www.rts.rs/"}.to_json}
			it "returns status 422" do
				expect(response.status).to eq 422
			end

			it "returns error message" do
				expect(json["message"]).to eq("Input parameters are invalid")
			end
		end

		context "when headers are invalid" do
			let(:headers) {invalid_headers}
			it "returns status 401" do
				expect(response.status).to eq 401
			end

			it "returns error message" do
				expect(json["message"]).to eq('Missing token')
			end

			context "when trying to update other users website" do
				let(:second_user) {create(:user, email: "newradnommail@gmial.com", name: "Bob")}
				let(:headers) { valid_headers(second_user)}
				it "returns status code 403" do
					expect(response.status).to eq 403
				end
			end
		end
	end
end