class ChangeAccessCountDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :short_links, :access_count, :integer, :default => 0
  end
end
