class ObjectSnapshot < ApplicationRecord
  serialize :object_changes, JSON
end
