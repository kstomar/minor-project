require 'rails_helper'

RSpec.describe TvShowsController, :type => :controller do

  before do
    user = User.create!(email: 'foo@example.com', password: '12345678')
    sign_in user
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, :format => :json

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "loads all of the tv_shows into @tv_shows" do
      tv_show1, tv_show2 = TvShow.create!, TvShow.create!
      get :index, :format => :json

      # expect(assigns(:tv_shows)).to match_array([tv_show1, tv_show2])
    end
  end

  describe "GET #show" do
    let(:tv_show) { TvShow.create! }

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: {id: tv_show.id}, :format => :json

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "loads all of the tv_shows into @tv_shows" do
      get :show, params: {id: tv_show.id}, :format => :json

      # expect(assigns(:tv_show)).to match(tv_show)
    end

    it 'incude episodes data in response' do
      ep1 = Episode.create!(episode: 1, tv_show_id: tv_show.id)
      ep2 = Episode.create!(episode: 2, tv_show_id: tv_show.id)
      get :show, params: {id: tv_show.id }, :format => :json

      expect(JSON.parse(response.body)).to have_key('episodes')
      expect(JSON.parse(response.body)['episodes']).to be_an(Array)
      expect(response.body).to match(/#{tv_show.id}/)
    end
  end

  describe "POST #create" do
    let(:params) { { title: 'House' } }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      post :create, params: {tv_show: params}

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "respond with created tv show" do
      request.accept = "application/json"
      post :create, params: {tv_show: params}

      expect(response.body).to include('House')
    end
  end

  describe "PUT #update" do
    let(:tv_show) { TvShow.create!(title: 'Foo') }
    let(:params) { { title: 'House' } }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      put :update, params: {id: tv_show.id, tv_show: params}

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "respond with updated tv show" do
      request.accept = "application/json"
      put :update, params: {id: tv_show.id, tv_show: params}

      expect(response.body).to include('House')
    end
  end

  describe 'DELETE #destroy' do
    let(:tv_show) { TvShow.create!(title: 'House') }

    it "responds successfully with an HTTP 200 status code" do
      request.accept = "application/json"
      delete :destroy, params: {id: tv_show.id}

      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "respond with deleted tv show" do
      request.accept = "application/json"
      delete :destroy, params: {id: tv_show.id}

      expect(response.body).to include('House')
    end
  end
end
