require 'rails_helper'

RSpec.describe 'DELETE /websites/:website_id/rss_links/:id' do
	let!(:user) {create(:user)}
	let!(:website) {create(:website, user: user)}
	let!(:rss_link) {create(:rss_link, website: website)}
	let(:headers) { valid_headers(user) }
	let(:rss_link_id) {rss_link.id}
	let(:website_id) {rss_link.website.id}
	before { delete "/websites/#{website_id}/rss_links/#{rss_link_id}", params: {}, headers: headers}

	context "when request is valid" do
		it "returns status 204" do
			expect(response.status).to eq 204
		end

		it "deletes record" do
			expect(RssLink.where(id: rss_link.id)).not_to exist
		end
	end

		
	context "when headers are invalid" do
		let(:headers) {invalid_headers}
		it "returns status code 401" do
			expect(response.status).to eq 401
		end
	end

	context "when trying to destroy other users link" do
		let(:second_user) {create(:user, email: "newradnommail@gmial.com", name: "Bob")}
		let(:headers) { valid_headers(second_user)}
		it "returns status code 403" do
			expect(response.status).to eq 403
		end
	end

	context "when record doesnt exist" do
		context "when rss_link doesnt exist" do
			let(:rss_link_id) {-1}
			it "returns status 404" do
				expect(response.status).to eq 404
			end
		end

		context "when website doesnt exist" do
			let(:website_id) {-1}
			it "returns status 404" do
				expect(response.status).to eq 404
			end
		end
	end
end