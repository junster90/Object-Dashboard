class ObjectSnapshotCsvImporter
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
      raise Exceptions::IncorrectCsvHeadersError
    end
  end

  def new_instances_from_csv
    options = { user_provided_headers:  @headers,
                strip_white_space:      true,
                headers_in_file:        HEADERS_REQUIRED,
                value_converters:       { object_changes: StringToHashConverter }
              }

    rows = SmarterCSV.process(@file, options)

    check_duplicate(rows)

    objects = []
    rows.each do |object|
      instance = ObjectSnapshot.new(object)

      objects << instance if instance.valid? or raise Exceptions::InvalidCsvRecordError
    end

    objects
  end

  def check_duplicate(rows)
    rows.uniq.length != rows.length or raise Exceptions::DuplicateRecordsError
  end
end