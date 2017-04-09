module Response
  def json_response(object, status = :ok, options = {})
  	if options[:include]
    	render json: object, status: status, include: options[:include]
  	elsif options[:each_serializer]
  		render json: object, status: status, each_serializer: options[:each_serializer]
  	else
  		render json: object, status: status
  	end
  end
end