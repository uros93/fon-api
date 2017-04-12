require 'rails_helper'

RSpec.describe 'POST /websites/:website_id/rss_links' do 
	let!(:user) {create(:user)}
	let!(:website) {create(:website, user: user)}
	let(:headers) { valid_headers(user) }
	let(:website_id) {website.id}
	let(:valid_attributes){{name: "Some valid name", description: "Some valid description", link: "http://www.rts.rs/page/stories/sr/rss.html"}.to_json}
	before {post "/websites/#{website_id}/rss_links", params: valid_attributes, headers: headers}

	context "when request is valid" do
		it "returns status 201" do
			expect(response.status).to eq(201)
		end

		it "returns json" do
			expect(json_type).to eq "rss-links"
			expect(json_id).not_to be nil
			expect(json_attributes('name')).to eq "Some valid name"
			expect(json_attributes('link')).to eq "http://www.rts.rs/page/stories/sr/rss.html"
			expect(json_relationship_id('website')).to eq website_id
			expect(json_included_relationship_attribute('name')).to eq website.name
		end
	end

	context "when request is invalid" do
		context "when website_id is invalid" do
			let(:website_id) {-1}
			it "returns status 404" do
				expect(response.status).to eq(404)
			end
		end

		context "when website owner is not request sender" do
			let(:second_user) {create(:user, email: "newradnommail@gmial.com", name: "Bob")}
			let(:headers) { valid_headers(second_user)}
			it "returns status code 403" do
				expect(response.status).to eq 403
			end
		end

		context "when headers are invlaid" do
			let(:headers) {invalid_headers}
			it "returns status 401" do 
			 	expect(response.status).to eq 401
			end
		end

		context "when attributes are invalid" do
			context "when name and description are invalid" do 
				let(:valid_attributes) {{name: long_string(100), url:"http://www.rts.rs/page/stories/sr/rss.html", description: long_string(500)}.to_json}
					it "returns status 422" do 
				 		expect(response.status).to eq 422
					end
			end

			context "when url is invalid" do
				let(:valid_attributes){{name: "Some valid name", description: "Some valid description", link: "http://www.rts.rs"}.to_json}
				it "returns status 422" do 
			 		expect(response.status).to eq 422
				end

				it "returns error message" do
					expect(json['message']).to eq "Validation failed: Link RSS link is invalid"
				end
			end
		end
	end
end