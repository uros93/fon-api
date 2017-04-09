class CreateRssLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :rss_links do |t|
      t.text :link
      t.string :name
      t.text :description
      t.references :website, foreign_key: true

      t.timestamps
    end
  end
end
