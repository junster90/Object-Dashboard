class ObjectSnapshotCsvImporter
  class IncorrectCsvHeadersError < StandardError; end
  class InvalidCsvRecordError < StandardError; end
  class DuplicateRecordsError < StandardError; end

  HEADERS_REQUIRED = true
  REQUIRED_HEADERS = ['object_id', 'object_type', 'timestamp', 'object_changes']

  def initialize(file)
    @file = file
    @headers = check_headers
    @objects = new_instances_from_csv
  end

  def import
    ObjectSnapshot.import(@objects, validate: true )
  end

  private

  def check_headers
    provided_headers = CSV.open(@file) { |head| head.readline.reject(&:nil?) }

    if provided_headers.sort == REQUIRED_HEADERS.sort
      provided_headers
    else
      raise IncorrectCsvHeadersError, "Invalid CSV headers provided. Please check that your headers include ['object_id', 'object_type', 'timestamp', 'object_changes'] and try again."
    end
  end

  def new_instances_from_csv
    options = { user_provided_headers: @headers, strip_white_space: true, headers_in_file: HEADERS_REQUIRED, value_converters: { object_changes: StringToHashConverter }}

    rows = SmarterCSV.process(@file, options)

    check_duplicate(rows)

    objects = []
    rows.each do |object|
      instance = ObjectSnapshot.new(object)
      if instance.valid?
        objects << instance
      else
        raise InvalidCsvRecordError, "There are invalid records in your CSV file. Please ensure there are no blanks or existing saved records in your file."
      end
    end

    objects
  end

  def check_duplicate(rows)
    if rows.uniq.length != rows.length
      raise DuplicateRecordsError, "There are duplicates in your CSV file. Please ensure there are no duplicates before uploading."
    end
  end
end