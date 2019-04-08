class CreateTvShows < ActiveRecord::Migration[5.2]
  def change
    create_table :tv_shows do |t|
      t.string :title
      t.text :description
      t.integer :rank

      t.timestamps null: false
    end
  end
end
