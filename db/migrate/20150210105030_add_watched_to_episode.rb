class AddWatchedToEpisode < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :watched, :boolean
  end
end
