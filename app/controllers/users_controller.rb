class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

	def create
		user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
	end

  def show
    @user = User.find(params[:id])
    json_response(@user, :ok)
  end

  def index
    @users = User.where.not(id: @current_user.id)
    status = @users.empty? ? :no_content : :ok
    json_response(@users, status)
  end

  def update
    raise ExceptionHandler::InvalidAttribute.new(Message.invalid_parameters) unless @current_user.update(user_params)
    json_response(@current_user, :accepted)
  end

  def profile
    render json: @current_user, status: :ok, serializer: ProfileSerializer
  end

	private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
