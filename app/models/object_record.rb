class ObjectRecord < ApplicationRecord
  serialize :object_changes, Hash

  validates :object_id, :object_type, :timestamp, :object_changes, presence: true
  validates :timestamp, uniqueness: { scope: [ :object_id, :object_type ] }

  def self.search(options)
    object_id = options[:object_id]
    object_type = options[:object_type]
    timestamp = Time.parse(options[:timestamp]).to_i || Time.now.to_i

    self.where(object_id: object_id, object_type: object_type).where('timestamp <= ?', timestamp)
  end
end
