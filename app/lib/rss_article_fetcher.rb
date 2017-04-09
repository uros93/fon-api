module RssArticleFetcher
	class Fetch
		def initialize(link)
			@link = link
		end

		def call
			begin
				require 'rss'
				require 'open-uri'
				articles = []
				open(@link) do |rss|
					feed = RSS::Parser.parse(rss, false, false)
					feed.items.each do |item|
						articles << Article.new(title: item.try(:title), description: item.try(:description), link: item.try(:link), image: item.try(:image))
					end
				end
				articles
			rescue Exception => e
				puts "USAO #{e}"
				raise ActiveRecord::RecordInvalid.new
			end
		end

		private

		attr_reader :link
	end
end