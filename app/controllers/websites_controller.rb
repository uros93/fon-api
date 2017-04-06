class WebsitesController < ApplicationController
	before_action :set_user, only: [:index, :create]

	def index
		@webistes = Website.where(user: @user)
		raise ActiveRecord::RecordNotFound.new(Message.not_found("website")) if @webistes.empty?
		render json: @webistes, status: :ok
	end

	def create
		@website = Website.create!(website_params)
		json_response(@website, :created)
	end

	private

	def set_user
		@user = User.find(params[:user_id].to_i)
	end

	def website_params
		params.permit( :name , :url,:description,:user_id)
	end
end
