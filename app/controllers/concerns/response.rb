module Response
  def json_response(object, status = :ok, options = {})
  	if options[:include]
    	render json: object, status: status, include: options[:include]
  	else
  		render json: object, status: status
  	end
  end
end