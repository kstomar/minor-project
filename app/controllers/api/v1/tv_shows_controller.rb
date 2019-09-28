module Api
  module V1
    class TvShowsController < Api::V1::ApiController
      before_action :authenticate_user!
      before_action :set_tv_show, except: [:index, :create]

      def index
        @tv_shows = TvShow.all
        respond_to do |format|
          format.json { render :json => @tv_shows }
        end
      end

      def show
        @tv_show = TvShow.find(params[:id])
        respond_to do |format|
          format.json { render :json => @tv_show }
        end
      end

      def create
        @tv_show = TvShow.new(tv_show_params)
        @tv_show.user_id = current_user.id
        if @tv_show.save
          respond_to do |format|
            format.json { render :json => @tv_show }
          end
        end
      end

      def update
        @tv_show = TvShow.find(params[:id])
        if @tv_show.update_attributes(tv_show_params)
          respond_to do |format|
            format.json { render :json => @tv_show }
          end
        end
      end

      def destroy
        @tv_show = TvShow.find(params[:id])
        @tv_show.delete
        respond_to do |format|
          format.json { render :json => @tv_show }
        end
      end

      private
      def tv_show_params
        params.require('tv_show').permit('title')
      end
    end
  end
end
