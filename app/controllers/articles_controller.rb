class ArticlesController < ApplicationController
	def index
		@articles = @current_user.filter_articles params
		json_response(@articles, :ok)
	end
end
