module Api
  module V1
    class TvShowSerializer < ActiveModel::Serializer
      attributes :id, :title, :episodes

      def episodes
        object.episodes
      end
    end
  end
end
