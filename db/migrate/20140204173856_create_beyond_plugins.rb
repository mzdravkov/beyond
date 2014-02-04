class CreateBeyondPlugins < ActiveRecord::Migration
  def change
    create_table :beyond_plugins do |t|
      t.string   "name"
      t.text     "description"
      t.boolean  "public"
      t.integer  "tenant_id"
      t.boolean  "activated"
      t.string   "archive_file_name"
      t.string   "archive_content_type"
      t.integer  "archive_file_size"
      t.datetime "archive_updated_at"

      t.timestamps
    end
  end
end
