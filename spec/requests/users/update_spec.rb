require 'rails_helper'

RSpec.describe 'PUT /profile/update' do
	let!(:user) {create(:user)}
	let(:headers) { valid_headers(user) }
	let(:attributes) {{name: "Some new name", email: "uniqemail@rand.org", password: "random123"}.to_json}

	before {put '/profile/update' ,params: attributes, headers: headers}

	context "when request is valid" do
		it "returns status 202" do
			expect(response.status).to eq 202
		end

		it "returns json" do
			user_changed = User.find(user.id)
			expect(json_id).to eq user.id
			expect(json_type).to eq 'users'
			expect(json_attributes('name')).to eq "Some new name"
			expect(json_attributes('email')).to eq "uniqemail@rand.org"
			expect(user_changed.authenticate("random123")).to be user_changed
			expect(user_changed.authenticate("random")).to be false
			expect(json_relationships['websites']['data'].size).to eq user.websites.size
		end
	end

	context "when request is invalid" do
		context "when headers are invalid" do 
			let(:headers){invalid_headers}
			it "return status 401" do
				expect(response.status).to eq 401
			end
		end

		context "when attributes are invalid" do
			let(:attributes) {{name: "", email: ""}.to_json}
			it "return status 422" do
				expect(response.status).to eq 422
			end
		end
	end
end 