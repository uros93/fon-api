require 'rails_helper'

RSpec.describe 'POST /categories' do 
	let!(:user) { create(:user) }
	let(:headers) { valid_headers(user) }
	let(:user_id) {user.id}
	let(:valid_attributes) {{name: "Random"}.to_json}
	before {post '/categories', params: valid_attributes, headers: headers}

	context "when request is valid" do 
		it "returns status 201" do
			expect(response.status).to eq(201)
		end

		it "returns newly created website" do
			expect(json_attributes("name")).to eq("Random")
			expect(json_included_relationship_attribute("name")).to eq(user.name)
		end
	end

	context "when request is invalid" do
		context "when headers are invalid" do 
			let(:headers){invalid_headers}
			it "returns status 401" do
				expect(response.status).to eq 401
			end
		end

		context "when attributes are not valid" do
			let(:valid_attributes){{name: ""}.to_json}
			it "returns status 422" do
				expect(response.status).to eq 422
			end

			it "returns errors message" do
				expect(json['message']).to eq "Input parameters are invalid"
			end
		end
	end
end