module Beyond
  class PluginsController < ApplicationController
    def new
      @plugin = Plugin.new
    end

    def create
      tenant_name = params[:plugin].delete :tenant
      @plugin = Plugin.new(plugin_params)
      @plugin.tenant = Tenant.find_by_name(tenant_name)
      if @plugin.save
        redirect_to root_url, notice: 'You have successfully uploaded a new plugin!'
      else
        errors = @plugin.errors.messages.map { |k, v| k.to_s+' ' + v.join(' and ')+' ' }
        redirect_to root_url, alert: 'There was an error while trying to create your plugin. ' + errors.join(' ')
      end
    end

    def start
      begin
        Plugin.find(params[:id]).start
        redirect_to root_url, notice: 'Plugin started'
      rescue
        redirect_to root_url, alert: 'Error: couldn\'t start plugin'
      end
    end

    def stop
      begin
        Plugin.find(params[:id]).stop
        redirect_to root_url, notice: 'Plugin stoped'
      rescue
        redirect_to root_url, alert: 'Error: couldn\'t stop plugin'
      end
    end

    private

    def plugin_params
      params.require(:plugin).permit(:name, :description, :public, :archive)
    end
  end
end
