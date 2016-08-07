class ObjectSnapshotsController < ApplicationController
  def index
    @objects = ObjectSnapshot.all
  end

  def new
  end

  def create
    importer = ObjectSnapshotCsvImporter.new(csv)

    importer.import
    flash[:success] = "Successfully imported from CSV!"
    redirect_to root_path

    rescue ArgumentError
      flash[:alert] = "There was a problem with your CSV file."
      redirect_to new_object_snapshot_path
    rescue => e
      flash[:alert] = e.message
      redirect_to new_object_snapshot_path
  end

  private

  def csv
    params.require(:object_batch).permit(:file)[:file].tempfile
  end
end
