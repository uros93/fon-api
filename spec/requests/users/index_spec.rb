require 'rails_helper'

RSpec.describe 'GET /users' do 
	let!(:user) {create(:user)}
	let!(:other_users) {create_list(:user, 10)}
	let(:headers) { valid_headers(user) }
	before { get "/users", params: {}, headers: headers }

	context "when request is valid" do
		it "returns status 200" do
			expect(response.status).to eq 200
		end

		it "returns json" do
			expect(json_data.size).to eq other_users.size
			expect(json_data.map{|x| x['id'].to_i}).to eq other_users.pluck(:id)
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

	context "when there are no other users" do
		let(:other_users) {}

		it "returns status 204" do
			expect(response.status).to eq 204
		end

		it "returns empty json" do
			expect(response.body).to be_empty
		end
	end

end