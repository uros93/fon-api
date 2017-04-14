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
			expect(json_relationships['categories']).to be nil
		end
	end

	context "when request is invalid" do
		context "when user id is invalid" do
			let(:user_id) {-1}
			it "returns status 404" do
				expect(response.status).to eq 404
			end
		end

		context "when headers are invalid" do 
			let(:headers){invalid_headers}
			it "return status 401" do
				expect(response.status).to eq 401
			end
		end
	end
end