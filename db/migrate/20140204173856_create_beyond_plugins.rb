class CreateBeyondPlugins < ActiveRecord::Migration
  def change
    create_table :beyond_plugins do |t|
      t.string   "name"
      t.text     "description"
      t.boolean  "public"
      t.integer  "tenant_id"
      t.boolean  "activated"

      t.timestamps
    end
  end
end
