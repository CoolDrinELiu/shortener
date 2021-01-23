class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.integer :clicks, default: 0
      t.string :url
      t.string :target_url
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :short_urls, :url, unique: true
  end
end
