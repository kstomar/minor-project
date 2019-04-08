class AddUserToTvShow < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_shows, :user_id, :integer
  end
end
