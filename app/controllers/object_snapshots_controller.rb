class ObjectSnapshotsController < ApplicationController
  def create
    records = ObjectRecord.search(search_query_params)

    @result = records.map(&:object_changes).reduce(&:merge).sort.to_h

    redirect_to root_path
  end

  private

  def search_query_params
    params.require(:search).permit(:object_id, :object_type, :timestamp)
  end
end
