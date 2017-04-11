class CreateCategoryLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :category_links do |t|
      t.references :category, foreign_key: true, index: true
      t.references :rss_link, foreign_key: true, index: true

      t.timestamps
    end
  end
end
