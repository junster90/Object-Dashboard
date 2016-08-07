class ObjectSnapshotsController < ApplicationController
  def index
    @objects = ObjectSnapshot.all
  end

  def new
  end

  def create
    if ObjectSnapshotCsvImporter.import(csv)
      flash[:success] = "Successfully imported from CSV!"
      redirect_to root_path
    else
      flash[:alert] = "Invalid CSV format! Please check for any errors and try again."
      redirect_to new_object_snapshot_path
    end
  end

  private

  def csv
    params.require(:object_batch).permit(:file)[:file].tempfile
  end
end
