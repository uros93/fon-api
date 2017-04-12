require 'rails_helper'

RSpec.describe 'GET /users/:id' do 
	let!(:user) {create(:user)}
	let(:headers) { valid_headers(user) }
	let!(:second_user) {create(:user)}
	let(:user_id){second_user.id}
	before { get "/users/#{user_id}", params: {}, headers: headers}

	context "when request is valid" do
		it "returns status 200" do
			expect(response.status).to eq 200
		end

		it "returns json" do
			expect(json_id).to eq second_user.id
			expect(json_type).to eq 'users'
			expect(json_attributes('name')).to eq second_user.name
			expect(json_attributes('email')).to eq second_user.email
			expect(json_relationships['websites']['data'].size).to eq second_user.websites.size
		end

	end
end