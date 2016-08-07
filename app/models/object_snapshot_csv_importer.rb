class ObjectSnapshotCsvImporter
  class IncorrectCsvHeadersError < StandardError; end

  HEADERS_REQUIRED = true
  REQUIRED_HEADERS = ['object_id', 'object_type', 'timestamp', 'object_changes']

  def self.import(file)
    self.new(file)
    ObjectSnapshot.import(@objects, validate: true )

    rescue IncorrectCsvHeadersError
      false
  end

  def initialize(file)
    @file = file
    @headers = check_headers
    @objects = new_instances_from_csv
  end

  private

  def check_headers
    provided_headers = CSV.open(@file) { |head| head.readline.reject(&:nil?) }

    provided_headers.sort == REQUIRED_HEADERS.sort or raise IncorrectCsvHeadersError

    provided_headers
  end

  def new_instances_from_csv
    options = { user_provided_headers: @headers, strip_white_space: true, headers_in_file: HEADERS_REQUIRED, value_converters: { object_changes: StringToHashConverter }}

    objects = []
    SmarterCSV.process(@file, options) do |array|
      objects << ObjectSnapshot.new(array.first)
    end

    objects
  end
end