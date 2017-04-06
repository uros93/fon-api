require 'rails_helper'

RSpec.describe 'GET user/:id/websites' do 
	let!(:user) { create(:user) }
	let!(:websites) { create_list(:website, 10, user: user ) }
	let(:headers) { valid_headers }
	let(:user_id) {user.id}
	before { get "/users/#{user_id}/websites", params: {}, headers: headers }

	context "valid user" do 
		it "returns json" do 
			expect(json).not_to be_empty
	    expect(json[:websites].size).to eq(10)
		end
	end

	context "invalid user" do 
		let(:user_id) {"random"}
		it "returns 404 status code" do
			expect(response.status).to eq(404)
		end
	end

	context "invalid headers" do 
		let(:headers) {invalid_headers}
		it "returns 422 status code" do
			expect(response.status).to eq(422)
		end
	end

end