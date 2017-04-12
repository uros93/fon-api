require 'rails_helper'

RSpec.describe 'PUT /websites/:id' do
	let!(:user) {create(:user)}
	let!(:website) {create(:website, user: user)}
	let(:headers) { valid_headers(user) }
	let(:website_id) {website.id}
	let(:attributes) {{name:"N1", description:"Random description", url: "https://somerandomurl.com"}.to_json}
	before { put "/websites/#{website_id}", params: attributes, headers: headers}

	context "when request is valid" do
		it "returns status code 202" do
			expect(response.status).to eq 202
		end

		it "returns json" do
			expect(website.name).not_to eq "N1"
			expect(json_id).to eq website.id
			expect(json_type).to eq "websites"
			expect(json_attributes("name")).to eq "N1"
			expect(json_attributes("description")).to eq "Random description"
			expect(json_attributes("url")).to eq "https://somerandomurl.com"
			expect(json_included_relationship_attribute("name")).to eq user.name
			expect(json_included_relationship_attribute("email")).to eq user.email
		end
	end
	context "when only one attribute is passed" do
		let(:attributes) {{name:"SomeName"}.to_json}
		it "returns json" do
			expect(json_attributes("name")).to eq "SomeName"
			expect(json_attributes("url")).to eq website.url
		end
	end

	context "when request is invalid" do 
		context "when attributes are invalid" do 
			let(:attributes) {{name:""}.to_json}
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