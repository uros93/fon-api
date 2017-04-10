module RssArticleFetcher
	require 'action_view'
	class Fetch
		include ActionView::Helpers::SanitizeHelper
		def initialize(link, website)
			@link = link
			@website = website
		end

		def call
			begin
				require 'rss'
				require 'open-uri'
				require 'nokogiri'
				articles = []
				open(@link) do |rss|
					if Rails.cache.read(@link)
						feed = Rails.cache.read(@link)
					else
						feed = RSS::Parser.parse(rss, false, false)
						Rails.cache.write(@link,feed)
					end
					
					feed.items.each_with_index do |item, index|
						article = Article.new(id: index, title: strip_tags(item.try(:title)), description: strip_tags(item.try(:description)), link: item.try(:link), image: item.try(:image), website: @website)
						unless article.image
							doc = Nokogiri::HTML(item.description)
							img_src = doc.css('img').map{ |i| i['src'] }.first
							article.image = img_src
						end
						articles << article
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