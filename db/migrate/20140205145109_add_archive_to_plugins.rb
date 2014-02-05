class AddArchiveToPlugins < ActiveRecord::Migration
  def change
    add_attachment :beyond_plugins, :archive
  end
end
