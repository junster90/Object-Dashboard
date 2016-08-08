class ObjectRecordsController < ApplicationController
  def new
  end

  def create
    importer = ObjectRecordCsvImporter.new(csv)

    importer.import
    flash[:success] = "Successfully imported from CSV!"
    redirect_to root_path

    rescue ArgumentError
      flash[:alert] = "There was a problem with your CSV file."
      redirect_to new_object_record_path
    rescue => e
      flash[:alert] = e.message
      redirect_to new_object_record_path
  end

  private

  def csv
    params.require(:object_batch).permit(:file)[:file].tempfile
  end
end
