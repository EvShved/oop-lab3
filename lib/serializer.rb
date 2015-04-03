class Serializer
  def self.serialize_array(array)
    array.map { |item| object_to_hash(item) }.to_json
  end

  def self.deserialize_array(json)
    JSON.load(json).map { |item| hash_to_object(item) }
  end

  private

  def self.object_to_hash(object)
    variable_names = object.instance_variables
    variables = {}

    variable_names.each do |name|
      variables[name] = object.instance_variable_get(name)
    end

    {
      class: object.class.name,
      instance_variables: variables
    }
  end

  def self.hash_to_object(hash)
    object = hash['class'].constantize.new

    hash['instance_variables'].each do |name, value|
      object.instance_variable_set(name, value)
    end

    object
  end
end
