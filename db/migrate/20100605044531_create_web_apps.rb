class CreateWebApps < ActiveRecord::Migration
  def self.up
    create_table :web_apps do |t|
      t.string :name
      t.string :url
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :web_apps
  end
end
