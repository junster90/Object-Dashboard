class ObjectSnapshotCsvImporter
  class IncorrectCsvHeadersError < StandardError; end

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

  def new_instances_from_csv
    options = { user_provided_headers: @headers, strip_white_space: true, headers_in_file: HEADERS_REQUIRED, value_converters: { object_changes: StringToHashConverter }}

    objects = []
    SmarterCSV.process(@file, options) do |array|
      objects << ObjectSnapshot.new(array.first)
    end

    objects
  end

  def check_headers
    provided_headers = CSV.open(@file) { |head| head.readline.reject(&:nil?) }

    raise IncorrectCsvHeadersError if provided_headers.sort != REQUIRED_HEADERS.sort

    provided_headers
  end
end