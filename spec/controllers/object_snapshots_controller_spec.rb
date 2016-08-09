require 'rails_helper'

describe ObjectSnapshotsController do
  describe 'POST #create' do
    context 'with a result found' do
      let(:query) { { object_id: "1", object_type: "ObjectA", timestamp: "" } }
      let(:snapshots_builder) { ObjectSnapshotsBuilder.new(params) }

      subject { post :create, xhr: true, params: {search: query}, format: 'js' }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context 'without any result found' do

    end
  end

end
