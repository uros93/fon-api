class CategoriesController < ApplicationController
	before_action :set_category, except: [:create, :index]
	before_action :check_owner, except: [:create, :index]	
	
	def show		
		json_response(@category, :ok, {include: [:rss_links]})
	end

	def create
		@category = Category.new(category_params)
		@category.user = @current_user
		raise ExceptionHandler::InvalidAttribute.new(Message.invalid_parameters) unless @category.save
		json_response(@category, :created, {include: [:user]})
	end

	def index
		@categories = @current_user.categories
		@categories.size > 0 ? json_response(@categories, :ok) : json_response([], :no_content)
	end

	def update
		raise ExceptionHandler::InvalidAttribute.new(Message.invalid_parameters) unless @category.update(category_params)
		json_response(@category, :accepted)
	end

	def destroy
		@category.destroy
		json_response([], :no_content)
	end

	private

	def set_category
		@category = Category.find(params[:id])
	end

	def check_owner
		raise ExceptionHandler::Forbidden unless @category.user == @current_user
	end

	def category_params
		params.permit(:name)
	end
end
