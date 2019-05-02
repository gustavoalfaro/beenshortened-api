class CreateShortLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :short_links do |t|
      t.string :slug
      t.text :redirect_link
      t.integer :access_count
      t.text :page_title

      t.timestamps
    end
  end
end
