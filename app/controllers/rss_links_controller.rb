class RssLinksController < ApplicationController
	before_action :set_website
	before_action :check_owner, only: [:create, :update, :destroy]

	def show
		@rss_link = RssLink.find(params[:id])
		@articles = RssArticleFetcher::Fetch.new(@rss_link.link, @website).call
		json_response(@articles, :ok)
	end

	def create
		@rss_link = @website.rss_links.create!(rss_links_params)
		json_response(@rss_link, :created, {include: [:website]})
	end

	def index
		@rss_links = @website.rss_links
		json_response(@rss_links, :ok, {include: [:website]})
	end

	def update
		@rss_link = RssLink.find(params[:id])
		raise ExceptionHandler::InvalidAttribute.new(Message.invalid_parameters) unless @rss_link.update(rss_links_params)
		json_response(@rss_link, :accepted, {include: [:website]})
	end

	def destroy
		@rss_link = RssLink.find(params[:id])
		@rss_link.destroy
		json_response(nil, :no_content)
	end

	private

	def set_website
		@website = Website.find(params[:website_id])
	end

	def check_owner
		raise ExceptionHandler::Forbidden unless @website.user == @current_user
	end


	def rss_links_params
		params.permit(:name,:description, :link)
	end
end
