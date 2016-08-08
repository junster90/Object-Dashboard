class ObjectSnapshotsBuilder
  def initialize(query)
    @object_id = query[:object_id]
    @object_type = query[:object_type]
    @timestamp = timestamp_queried_or_now(query[:timestamp])
  end

  def build
    records = ObjectRecord.search(@object_id, @object_type, @timestamp.to_i)

    return nil if records.blank?

    properties = unify_properties(records)
    ObjectSnapshot.new(@object_id, @object_type, @timestamp, properties)
  end

  private

  def timestamp_queried_or_now(timestamp)
    timestamp.blank? ? Time.now : Time.parse(timestamp)
  end

  def unify_properties(records)
    records.map(&:object_changes).reduce(&:merge).sort.to_h
  end
end