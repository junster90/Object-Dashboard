class ObjectSnapshot
  attr_reader :object_id, :object_type, :properties

  def initialize(id, type, properties)
    @object_id = id
    @object_type = type
    @properties = properties
  end
end