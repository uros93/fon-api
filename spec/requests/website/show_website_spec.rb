require 'rails_helper'

RSpec.describe 'GET user/:id/websites' do 
	let!(:user) { create(:user) }
	let!(:websites) { create_list(:website, 10, user: user ) }
	let(:headers) { valid_headers }
	before { get "/users/#{user.id}/websites", params: {}, headers: headers }

	context "valid user" do 
		it "returns json" do 
			expect(json).not_to be_empty
	    expect(json.size).to eq(10)
		end
	end

end