require 'rails_helper'

RSpec.describe 'POST /websites' do 
	let!(:user) { create(:user) }
	let(:headers) { valid_headers }
	let(:user_id) {user.id}
	let(:valid_attributes) {{name: "Random", url:"https://random.org", description: "Some random things", user_id: user_id}.to_json}
	before {post '/websites', params: valid_attributes, headers: headers}

	context "When request is valid" do 
		it "returns status 202" do
			expect(response.status).to eq(201)
			expect(response.body[:name]).to eq("Random")
		end

		# it "returns newly created website" do
		# 	expect(json[:name]).to eq("Random")
		# 	expect(json[:url]).to eq("https://random.org")
		# 	expect(json[:description]).to eq("Some random things")
		# 	expect(json[:user_id]).to eq(user_id)
		# end
	end
end