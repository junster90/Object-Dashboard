class ObjectSnapshot < ApplicationRecord
  serialize :object_changes, Hash
end
