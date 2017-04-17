class WebsitesController < ApplicationController
	before_action :set_website, only: [:show, :update, :destroy, :articles]
	before_action :check_owner, only: [:update, :destroy]

	def index
		@websites = Website.all
		raise ActiveRecord::RecordNotFound.new(Message.not_found("website")) if @websites.empty?
		json_response(@websites, :ok)
	end

	def create
		@website = Website.new(website_params)
		@website.user = @current_user
		raise ExceptionHandler::InvalidAttribute.new(Message.invalid_parameters) unless @website.save
		json_response(@website, :created, {include: [:user]})
	end

	def show
		json_response(@website, :ok, include: [:user])
	end

	def update
		raise ExceptionHandler::InvalidAttribute.new(Message.invalid_parameters) unless @website.update(website_params) 
		json_response(@website, :accepted, {include: [:user]})
	end

	def destroy
		@website.destroy
		json_response(nil, :no_content)
	end

	def articles
		@articles = RssArticleFetcher::FetchAll.new(@website.rss_links).call
		status = @articles.empty? ? :no_content : :ok
		json_response(@articles, status)
	end

	private

	def set_website
		@website = Website.find(params[:id])
	end

	def check_owner
		raise ExceptionHandler::Forbidden unless @website.user == @current_user
	end

	def website_params
		params.permit( :name , :url,:description)
	end
end
