class Serializer
  def self.serialize(object)
    variable_names = object.instance_variables
    variables = {}

    variable_names.each do |name|
      variables[name] = object.instance_variable_get(name)
    end

    {
      class: object.class.name,
      instance_variables: variables
    }.to_json
  end

  def self.deserialize(json)
    hash = JSON.load(json)
    object = hash['class'].constantize.new

    hash['instance_variables'].each do |name, value|
      object.instance_variable_set(name, value)
    end

    object
  end
end
