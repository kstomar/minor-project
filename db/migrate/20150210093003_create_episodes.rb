class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.integer :tv_show_id, null: false
      t.string :title
      t.integer :episode

      t.timestamps null: false
    end
  end
end
