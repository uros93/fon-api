class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      t.string :name
      t.string :url
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
