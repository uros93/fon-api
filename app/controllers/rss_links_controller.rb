class RssLinksController < ApplicationController
	def show
		@website = Website.find(params[:website_id])
		@rss_link = RssLink.find(params[:id])
		@articles = RssArticleFetcher::Fetch.new(@rss_link.link).call
		# @articles = ActiveModelSerializers::SerializableResource.new(@articles)
		render json: @articles, each_serializer: ArticleSerializer
		# json_response(@articles, :ok)
	end
end
