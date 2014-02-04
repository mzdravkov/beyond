module Beyond
  class TenantsController < ApplicationController
    def new
      @tenant = Tenant.new
    end

    def create
      tenant = Tenant.new(create_params)
      tenant.user = current_user
      begin
        if tenant.save
          redirect_to root_url, notice: "You have successfully created #{tenant.name}"
        else
          errors = tenant.errors.messages.map { |k, v| k.to_s+' ' + v.join(' and ')+' ' }
          redirect_to root_url, alert: "There was an error while trying to create #{tenant.name}. " + errors.join(' ')
        end
      rescue
        redirect_to root_url, alert: "There was an error while trying to create #{tenant.name}. "
      end
    end

    def show
      @tenant = Tenant.find(params[:id])
    end

    def edit
      @tenant = Tenant.find(params[:id])
      @configs = @tenant.configs.group_by { |_, v| v['category'] }
    end

    def update
      tenant = Tenant.find(params[:id])
      changes = params.select { |k, _| k =~ /^config_.+/ }
      changes = Hash[changes.map { |k, v| [k.to_s.sub(/^config_/, ''), v] }]
      begin
        tenant.update_configs changes
      rescue
        redirect_to root_url, alert: 'There was an error while trying to save your configurations to file.'
        return
      end
      redirect_to root_url, notice: 'You have successfully updated you configurations!'
    end

    def start
      begin
        Tenant.find(params[:id]).start
        redirect_to root_url, notice: 'Tenant started'
      rescue
        redirect_to root_url, alert: 'Error: couldn\'t start tenant'
      end
    end

    def stop
      begin
        Tenant.find(params[:id]).stop
        redirect_to root_url, notice: 'Tenant stoped'
      rescue
        redirect_to root_url, alert: 'Error: couldn\'t stop tenant'
      end
    end

    private

    def create_params
      params.require(:tenant).permit(:name)
    end
  end
end
