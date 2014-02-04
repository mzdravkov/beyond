class CreateBeyondTenants < ActiveRecord::Migration
  def change
    create_table :beyond_tenants do |t|
      t.string   "name"
      t.integer  "user_id"

      t.timestamps
    end
  end
end
