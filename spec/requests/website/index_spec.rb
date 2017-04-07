require 'rails_helper'

RSpec.describe 'GET /websites' do 
	let!(:user) { create(:user) }
	let!(:websites) { create_list(:website, 10, user: user ) }
	let(:headers) { valid_headers(user) }
	let(:user_id) {user.id}
	before { get "/websites", params: {}, headers: headers }

	context "valid user" do 
		it "returns json" do 
			expect(json_data).not_to be_empty
	    expect(json_data.size).to eq(10)
		end
	end

	context "invalid headers" do 
		let(:headers) {invalid_headers}
		it "returns 422 status code" do
			expect(response.status).to eq(422)
		end
	end

end