class CategoriesController < ApplicationController
	
	def show
		@category = Category.find(params[:id])
		json_response(@category, :ok, {include: [:rss_links]})
	end
end
