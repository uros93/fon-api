module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def json_data
  	json['data']
  end

  def json_attributes(name)
  	json_data['attributes'][name]
  end

  def json_type
  	json_data['type']
  end

  def json_id
  	json_data['id'].to_i
  end

  def json_relationships
  	json_data['relationships']
  end

  def json_relationship(name)
  	json_data['relationships'][name]
  end

  def json_relationship_attribute(name, attribute)
  	json_relationship(name)['data'][attribute]
  end
end