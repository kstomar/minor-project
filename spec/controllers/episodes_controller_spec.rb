require 'rails_helper'

RSpec.describe EpisodesController, :type => :controller do
  let!(:tv_show) { TvShow.create! }

  before do
    user = User.create!(email: 'foo@example.com', password: '12345678')
    sign_in user
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, params: {tv_show_id: tv_show.id}, :format => :json

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "loads all of the episodes into @episodes" do
      episode1, episode2 = Episode.create!(tv_show_id: tv_show.id), Episode.create!(tv_show_id: tv_show.id)
      get :index, params: {tv_show_id: tv_show.id}, :format => :json

      # expect(assigns(:episodes)).to match_array([episode1, episode2])
    end
  end

  describe "GET #show" do
    let(:episode) { Episode.create!(tv_show_id: tv_show.id) }

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: {id: episode.id, tv_show_id: tv_show.id}, :format => :json

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "loads all of the episodes into @episodes" do
      get :show, params: {id: episode.id, tv_show_id: tv_show.id}, :format => :json

      # expect(assigns(:episode)).to match(episode)
    end
  end

  describe "POST #create" do
    let(:params) { { title: 'House' } }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      post :create, params: { tv_show_id: tv_show.id, episode: params}

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "respond with created tv show" do
      request.accept = "application/json"
      post :create, params: {tv_show_id: tv_show.id, episode: params}

      expect(response.body).to include('House')
    end
  end

  describe "PUT #update" do
    let(:episode) { Episode.create!(title: 'Foo', tv_show_id: tv_show.id) }
    let(:params) { { title: 'House' } }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      put :update, params: {id: episode.id, tv_show_id: tv_show.id, episode: params}

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "respond with updated tv show" do
      request.accept = "application/json"
      put :update, params: {id: episode.id, tv_show_id: tv_show.id, episode: params}

      expect(response.body).to include('House')
    end
  end

  describe 'DELETE #destroy' do
    let(:episode) { Episode.create!(title: 'House', tv_show_id: tv_show.id) }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      delete :destroy, params: {id: episode.id, tv_show_id: tv_show.id}

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "respond with deleted tv show" do
      request.accept = "application/json"
      delete :destroy, params: {id: episode.id, tv_show_id: tv_show.id}

      expect(response.body).to include('House')
    end
  end
end
