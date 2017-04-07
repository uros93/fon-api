require 'rails_helper'

RSpec.describe 'GET /websites/:id' do 

	let!(:user) {create(:user)}
	let!(:webiste) {create(:website, user: user)}
	let(:headers) { valid_headers(user) }
	let(:webiste_id) {webiste.id}
	before { get "/websites/#{webiste_id}", params: {}, headers: headers}

	context "when request is valid" do 
		it "returns status 200" do
			expect(response.status).to eq 200
		end
		it "returns json" do
			expect(json_id).to eq webiste.id
			expect(json_type).to eq "websites"
			expect(json_attributes("name")).to eq webiste.name
			expect(json_attributes("description")).to eq webiste.description
			expect(json_attributes("url")).to eq webiste.url
			expect(json_relationship_attribute("user","name")).to eq user.name
			expect(json_relationship_attribute("user","email")).to eq user.email
		end
	end

	context "when request is invalid" do
		let(:webiste_id) {-1}
		it "returns status 404" do
			expect(response.status).to eq 404
		end
	end

	context "when headers are invalid" do 
		let(:headers){invalid_headers}
		it "return status 422" do
			expect(response.status).to eq 422
		end
	end
end