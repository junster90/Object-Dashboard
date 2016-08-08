class ObjectRecordsController < ApplicationController
  def create
    importer = ObjectRecordCsvImporter.new(csv)

    importer.import
    flash[:alert] = { type: "success", message: "Successfully imported from CSV!" }

    rescue ArgumentError
      flash[:alert] = { type: "danger", message: "There was a problem with your CSV file." }
    rescue => e
      flash[:alert] = { type: "danger", message: e.message }
    ensure
      redirect_to root_path
  end

  private

  def csv
    params.require(:object_batch).permit(:file)[:file].tempfile
  end
end
