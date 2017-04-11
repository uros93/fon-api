require 'rails_helper'

RSpec.describe 'GET /category/:id' do
	let!(:user) {create(:user)} 
	let!(:category) {create(:category, user: user)}
	let(:headers) { valid_headers(user) }
	let(:category_id) {category.id}

	before {get "/categories/#{category_id}", params: {}, headers: headers}

	context "when request is valid" do
		context "when category has no links" do
			it "returns status 200" do
				expect(response.status).to eq 200
			end

			it "returns json" do
				expect(json_id).to eq category.id
				expect(json_type).to eq 'categories'
				expect(json_attributes('name')).to eq category.name
				expect(json_relationship_id('user')).to eq user.id
				expect(json_included_data).to be nil
			end
		end

		context "when category has links" do
			let!(:category) {create(:category_with_links)}
			it "returns status 200" do
				expect(response.status).to eq 200
			end

			it "returns json" do
				expect(json_included_data.size).to eq category.rss_links.size
			end
		end
	end

	context "when request is invalid" do
	end
end