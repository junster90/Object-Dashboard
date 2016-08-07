module Exceptions
  class IncorrectCsvHeadersError < StandardError
    def initialize(msg = "Invalid CSV headers provided. Please check that your headers include ['object_id', 'object_type', 'timestamp', 'object_changes'] and try again.")
      super
    end
  end

  class InvalidCsvRecordError < StandardError
    def initialize(msg = "There are invalid records in your CSV file. Please ensure there are no blanks or existing saved records in your file.")
      super
    end
  end

  class DuplicateRecordsError < StandardError
    def initialize(msg = "There are duplicates in your CSV file. Please ensure there are no duplicates before uploading.")
      super
    end
  end
end