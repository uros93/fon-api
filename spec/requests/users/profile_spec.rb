require 'rails_helper'

RSpec.describe 'GET /profile' do
	let!(:user) {create(:user)}
	let(:headers) {valid_headers(user)}
	before { 
		user.websites = create_list(:website, 10, user: user)
		user.categories = create_list(:category, 10, user: user)
		get '/profile', params: {}, headers: headers
	}

	context "when request is valid" do
		it "returns status 200" do
			expect(response.status).to eq 200
		end

		it "returns json" do
			expect(json_id).to eq user.id
			expect(json_type).to eq 'users'
			expect(json_attributes('name')).to eq user.name
			expect(json_attributes('email')).to eq user.email
			expect(json_relationships['websites']['data'].size).to eq user.websites.size
			expect(json_relationships['categories']['data'].size).to eq user.categories.size
		end
	end

	context "when request is invalid" do
		context "when headers are invalid" do 
			let(:headers){invalid_headers}
			it "return status 401" do
				expect(response.status).to eq 401
			end
		end
	end

end