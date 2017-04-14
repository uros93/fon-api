module Response
  def json_response(object, status = :ok, options = {})
  	if options[:include]
    	render json: object, include: options[:include], status: status
  	elsif options[:each_serializer]
  		render json: object, status: status, each_serializer: options[:each_serializer]
  	else
  		render json: object, status: status
  	end
  end
end