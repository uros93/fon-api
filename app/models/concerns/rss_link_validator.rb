class RssLinkValidator < ActiveModel::Validator
	
	def validate(record)
		require 'rss'
		require 'open-uri'
		begin
			if options[:fields]
				url = record.send(options[:fields].first)
				open(url) do |rss|
					feed = RSS::Parser.parse(rss, false, false)
				end
			end
		rescue Exception => e
			record.errors[:link] << "RSS link is invalid"
		end
	end
end