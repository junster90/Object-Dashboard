class ObjectSnapshotsController < ApplicationController
  def index
  end

  def new
  end

  def create
    if ObjectSnapshotCsvImporter.new(csv).import
      redirect_to root_path
    else
      redirect_to new_object_snapshot_path
    end
  end

  private

  def csv
    params.require(:object_batch).permit(:file)[:file].tempfile
  end
end
