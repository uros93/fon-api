require 'rails_helper'

RSpec.describe 'GET /categories' do 
	let!(:user) { create(:user) }
	let!(:categories) { create_list(:category, 10, user: user ) }
	let(:headers) { valid_headers(user) }
	before { get "/categories", params: {}, headers: headers }

	context "when request is valid" do
		it "returns status 200" do
			expect(response.status).to eq(200)
		end

		it "returns json" do
			expect(json_data.size).to eq(10)
			json_data.each do |json_category|
				expect(json_category['relationships']['user']['data']['id'].to_i).to eq user.id
			end
			expect(json_data.size).to eq user.categories.size
		end
	end


	context "when there are no categories" do
		let(:categories) {}
		it "returns status 204" do
			expect(response.status).to eq(204)
		end

		it "returns empty json" do
			expect(response.body).to be_empty
		end
	end

	context "when request is invalid" do
		context "invalid headers" do 
			let(:headers) {invalid_headers}
			it "returns 401 status code" do
				expect(response.status).to eq(401)
			end
		end
	end
end