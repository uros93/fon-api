module RssArticleFetcher
	require 'action_view'
	class Fetch
		include ActionView::Helpers::SanitizeHelper
		def initialize(link, website, category_tags = "No category tags")
			@link = link
			@website = website
			@category_tags = ""
			if category_tags.respond_to?(:each)
				category_tags.each do |cat|
					@category_tags += (cat.try(:name) || cat).downcase
					@category_tags += ", " unless cat == category_tags.last
				end
			else
				@category_tags = category_tags.downcase
			end
		end

		def call
			begin
				require 'rss'
				require 'open-uri'
				require 'nokogiri'
				require 'securerandom'
				articles = []
				open(@link) do |rss|
					if Rails.cache.read(@link)
						feed = Rails.cache.read(@link)
					else
						feed = RSS::Parser.parse(rss, false, false)
						Rails.cache.write(@link,feed)
					end
					
					feed.items.each_with_index do |item, index|
						article = Article.new(id: SecureRandom.uuid, title: strip_tags(item.try(:title)), description: strip_tags(item.try(:description)), link: item.try(:link), image: item.try(:image), website: @website, category_tags: @category_tags )
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
				puts "USAO! #{e}"
				raise ActiveRecord::RecordInvalid.new
			end
		end

		private

		attr_reader :link
	end

	class FetchAll
		def initialize(array)
			@array = array
		end

		def call
			begin
				articles = []
				@array.each do |rss|
					articles += Fetch.new(rss.link, rss.website, rss.categories).call
				end
				articles
			rescue Exception => e
				puts "USAO! #{e}"
				raise ActiveRecord::RecordInvalid.new
			end
		end
	end
end