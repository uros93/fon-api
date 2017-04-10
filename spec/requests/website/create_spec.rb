require 'rails_helper'

RSpec.describe 'POST /websites' do 
	let!(:user) { create(:user) }
	let(:headers) { valid_headers(user) }
	let(:user_id) {user.id}
	let(:valid_attributes) {{name: "Random", url:"https://random.org", description: "Some random things", user_id: user_id}.to_json}
	before {post '/websites', params: valid_attributes, headers: headers}

	context "When request is valid" do 
		it "returns status 201" do
			expect(response.status).to eq(201)
		end

		it "returns newly created website" do
			expect(json_attributes("name")).to eq("Random")
			expect(json_attributes("url")).to eq("https://random.org")
			expect(json_attributes("description")).to eq("Some random things")
			expect(json_included_relationship_attribute("name")).to eq(user.name)
		end
	end

	context "When request is invalid" do
		context "When attributes are invalid" do
			let(:valid_attributes) {{name:"", url:"noturl", description: long_string(500)}.to_json}
			 it "returns status 422" do 
			 	expect(response.status).to eq 422
			 end

			 it "returns error message" do
			 	expect(json["message"]).to eq("Input parameters are invalid")
			 end
		end

		context "when headers are invalid" do
			let(:headers) {invalid_headers}
			it "returns status 422" do 
			 	expect(response.status).to eq 422
			end
			it "returns error message" do
				expect(json["message"]).to eq('Missing token')
			end
		end
	end
end