require 'rails_helper'

RSpec.describe 'GET /articles' do
	let!(:user) {create(:user)}
	let(:headers) { valid_headers(user) }
	let!(:category_1) {create(:category, user: user)}
	let!(:category_2) {create(:category, user: user)}
	let!(:category_3) {create(:category, user: user)}
	let!(:website_1) {create(:website, user: user)}
	let!(:website_2) {create(:website, user: user)}
	let!(:website_3) {create(:website, user: user)}
	let!(:params) {}
	let(:link_1) {parsed_link("http://www.blic.rs/rss/Vesti/Svet")}
	let(:link_2) {parsed_link("http://www.rts.rs/page/stories/sr/rss/10/svet.html")}
	let(:link_3) {parsed_link("http://www.b92.net/info/rss/sport.xml")}
	let(:link_4) {parsed_link("http://www.novosti.rs/rss/9%7C8%7C7-Sve%20vesti")}

	before { 
		category_1.rss_links << create(:rss_link, link: "http://www.blic.rs/rss/Vesti/Svet" , website: website_1)
		category_1.rss_links << create(:rss_link, link: "http://www.rts.rs/page/stories/sr/rss/10/svet.html", website: website_2)
		category_2.rss_links << create(:rss_link, link: "http://www.b92.net/info/rss/sport.xml", website: website_1)
		category_3.rss_links << create(:rss_link, link: "http://www.novosti.rs/rss/9%7C8%7C7-Sve%20vesti", website: website_3)
		get "/articles", params: params, headers: headers
	}


	context "when request is valid" do
		context "when there are no filters" do
			it "returns status 200" do
				expect(response.status).to eq 200
			end

			it "returns json" do
				expect(json_data.size).to eq link_1.size + link_2.size + link_3.size + link_4.size
			end
		end

		context "when there are category filters" do
			let(:params) {{categories: [category_1.name, category_2.name]}}
			it "returns json" do
				expect(json_data.size).to eq link_1.size + link_2.size + link_3.size
			end
		end

		context "when there are website filters" do
			let(:params) {{websites: [website_1.name, website_3.name]}}
			it "returns json" do
				expect(json_data.size).to eq link_1.size + link_3.size + link_4.size
			end
		end

		context "when there are website and category filters" do
			let(:params) {{websites: [website_1.name], categories: [category_3.name, category_2.name]}}
			it "returns json" do
				expect(json_data.size).to eq link_1.size + link_3.size + link_4.size
			end
		end
	end

end