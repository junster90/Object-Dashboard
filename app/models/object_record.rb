class ObjectRecord < ApplicationRecord
  serialize :object_changes, Hash

  validates :object_id, :object_type, :timestamp, :object_changes, presence: true
  validates :timestamp, uniqueness: { scope: [ :object_id, :object_type ] }
end
