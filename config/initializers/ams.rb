api_mime_types = %W(
	application/vnd.api+json
	text/x-json
	application/json
)
Mime::Type.register 'application/vnd.api+json', :json, api_mime_types
ActiveModelSerializers.config.adapter = :json_api
ActiveModelSerializers::Model.derive_attributes_from_names_and_fix_accessors