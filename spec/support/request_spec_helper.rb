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

  def json_relationship_id(name)
    json_data['relationships'][name]['data']['id'].to_i
  end

  def json_included_data
    json['included']
  end

  def json_included_relationship_attribute(attribute)
  	json['included'][0]['attributes'][attribute]
  end
end