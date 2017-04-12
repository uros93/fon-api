require 'rails_helper'

RSpec.describe 'PUT /categories/:id' do
	let!(:user) {create(:user)}
	let!(:category) {create(:category, user: user)}
	let(:headers) { valid_headers(user) }
	let(:category_id) {category.id}
	let(:attributes) {{name:"Random name"}.to_json}
	before { put "/categories/#{category_id}", params: attributes, headers: headers}

	context "when request is valid" do
		it "returns status 202" do
			expect(response.status).to eq(202)
		end

		it "returns json" do
			expect(json_attributes("name")).to eq "Random name"
			expect(json_relationship_id("user")).to eq user.id
		end
	end

	context "when request is invalid" do
		context "invalid headers" do 
			let(:headers) {invalid_headers}
			it "returns 401 status code" do
				expect(response.status).to eq(401)
			end
		end

		context "invalid params" do
			let(:attributes) {{name: ""}.to_json}
			it "returns 422 status code" do
				expect(response.status).to eq(422)
			end
		end

		context "non existing category" do
			let(:category_id) {-1}
			it "returns 404 status code" do
				expect(response.status).to eq(404)
			end
		end

		context "when trying to edit someone elses category" do
			let(:second_user) {create(:user)}
			let(:headers){valid_headers(second_user)}
			it "returns 403 status code" do
				expect(response.status).to eq(403)
			end
		end
	end
end