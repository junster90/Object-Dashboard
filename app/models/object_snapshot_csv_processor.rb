require 'csv'

class ObjectSnapshotCsvProcessor
  class IncorrectCsvHeadersError < StandardError; end

  REQUIRED_HEADERS = ['object_id', 'object_type', 'timestamp', 'object_changes']

  def initialize(file)
    @file = file
    @headers, @objects = csv_file_to_array
  end

  def import
    ObjectSnapshot.import(@headers, @objects, validate: true )
  end

  private

  def csv_file_to_array
    contents = CSV.foreach(@file).reject{|r| r.all?(&:nil?)}.map do |row|
      row.first(4)
    end

    headers = contents.shift

    raise IncorrectCsvHeadersError if incorrect_headers(headers)

    [headers, contents]
  end

  def incorrect_headers(headers)
    !headers.sort == REQUIRED_HEADERS.sort
  end
end