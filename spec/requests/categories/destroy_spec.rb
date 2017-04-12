require 'rails_helper'

RSpec.describe 'DELETE /categories/:id' do
	let!(:user) {create(:user)}
	let!(:category) {create(:category, user: user)}
	let(:headers) { valid_headers(user) }
	let(:category_id) {category.id}
	before { delete "/categories/#{category_id}", params: {}, headers: headers}

	context "when request is valid" do
		it "returns status 204" do
			expect(response.status).to eq 204
		end

		it "deletes record" do
			expect(Category.where(id: category.id)).not_to exist
		end

		it "returns empty body" do
			expect(response.body).to be_empty
		end
	end

		
	context "when headers are invalid" do
		let(:headers) {invalid_headers}
		it "returns status code 401" do
			expect(response.status).to eq 401
		end
	end

	context "when trying to destroy other users categories" do
		let(:second_user) {create(:user, email: "newradnommail@gmial.com", name: "Bob")}
		let(:headers) { valid_headers(second_user)}
		it "returns status code 403" do
			expect(response.status).to eq 403
		end
	end

	context "when record doesnt exist" do
		let(:category_id) {-1}
		it "returns status 404" do
			expect(response.status).to eq 404
		end
	end
end
