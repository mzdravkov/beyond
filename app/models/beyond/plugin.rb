module Beyond
  class Plugin < ActiveRecord::Base
    belongs_to :tenant

    validates :name, presence: true, format: {with: /\A[a-z_A-Z]+\z/, message: 'Only letters, underscore and numbers allowed.'}
    validates :description, presence: true

    has_attached_file :archive, path: File.join(ENV['tenants_plugins_dir'], ':plugin_tenant_name', ':filename')

    validates_attachment :archive, :presence => true,
      :content_type => { :content_type => "application/gzip" },
      :size => { :in => 0..10.megabytes }

    def extract
      Dir.chdir File.join(ENV['tenants_plugins_dir'], tenant.name) do
        unless Kernel.system "tar xzf #{archive_file_name}"
          throw "Can't extract archive"
        end
      end
    end

    def stop
      Dir.chdir File.join(ENV['tenants_plugins_dir'], tenant.name) do
        FileUtils.rm_r(name)
      end
      update_attribute(:activated, false)
    end

    def start
      extract
      update_attribute(:activated, true)
    end

    private

    Paperclip.interpolates :plugin_tenant_name do |attachment, style|
      attachment.instance.tenant.name
    end
  end
end
