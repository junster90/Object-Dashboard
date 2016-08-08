class ObjectSnapshot
  attr_reader :object_id, :object_type, :timestamp, :properties

  def initialize(id, type, timestamp, properties)
    @object_id = id
    @object_type = type
    @timestamp = timestamp
    @properties = properties
  end
end