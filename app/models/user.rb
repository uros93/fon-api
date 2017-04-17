class User < ApplicationRecord
	has_secure_password
	has_many :websites
	has_many :categories

	validates_presence_of :name, :email, :password_digest
	validates_uniqueness_of :name, :email

	def all_articles
		articles = []
		websites.each do |website|
			articles += RssArticleFetcher::FetchAll.new(website.rss_links).call
		end
		articles
	end

	def filter_articles(params)
		articles = []
		if params[:categories] || params[:websites]
			rss_links = []
			self.categories.where(name: params[:categories]).each do |c|
				c.rss_links.each {|rs| rss_links << rs}
			end
			self.websites.where(name: params[:websites]).each do |c|
				c.rss_links.each {|rs| rss_links << rs}
			end
			articles = RssArticleFetcher::FetchAll.new(rss_links.uniq(&:link)).call
		else
			articles = all_articles
		end
	end
end
