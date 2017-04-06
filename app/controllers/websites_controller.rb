class WebsitesController < ApplicationController
	before_action :set_user, only: [:index]

	def index
		@webistes = Website.where(user: @user)
		render json: @webistes, status: :ok
	end

	private

	def set_user
		@user = User.find(params[:user_id].to_i)
	end
end
