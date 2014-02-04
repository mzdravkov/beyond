module Beyond
  class Tenant < ActiveRecord::Base
    belongs_to :user
    has_many :plugins

    validates :name, presence: true, uniqueness: true
    validates_format_of :name, :with => /\A[0-9_a-z]+\z/

      after_create :deploy

    def configs
      YAML.load_file(File.join(ENV['tenants_configs_dir'], name + '.yml'))
    end

    def update_configs changes
      conf = configs
      changes.each do |k, v|
        if conf[k]['type'] == 'bool'
          conf[k]['value'] = (v == 'true')
        else
          conf[k]['value'] = v
        end
      end
      file = File.join(ENV['tenants_configs_dir'], name + '.yml')
      File.open file, 'w' do |f|
        f.print conf.to_yaml
      end
      PLUGINS.notify :on_update_configs, self
    end

    def deploy
      unless Kernel.system("#{ENV['kamino_bin']} deploy -name='#{name}'")
        throw 'Error creating tenant'
      end
      PLUGINS.notify :on_deploy, self
    end

    def stop
      unless Kernel.system("docker stop #{name}")
        throw 'Error stoping tenant'
      end
      PLUGINS.notify :on_stop, self
    end

    def start
      unless Kernel.system("docker start #{name}")
        throw 'Error starting tenant'
      end
      PLUGINS.notify :on_start, self
    end

    def working?
      !!(`docker top #{name}`.match /\d+/)
    end

    private

    def kamino_dir
      File.dirname(ENV['kamino_bin'])
    end
  end
end
