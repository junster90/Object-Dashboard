class ObjectSnapshotsBuilder
  def initialize(query)
    @object_id = query[:object_id]
    @object_type = query[:object_type]
    @timestamp = query[:timestamp]
  end

  def build
    records = ObjectRecord.search(@object_id, @object_type, @timestamp)
    properties = unify_properties(records)

    ObjectSnapshot.new(@object_id, @object_type, properties)
  end

  private

  def unify_properties(records)
    records.map(&:object_changes).reduce(&:merge).sort.to_h
  end
end