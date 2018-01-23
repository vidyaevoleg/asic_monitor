module Api
  class MachinesController < ::Api::ApplicationController

    def create
      machine = Machines::Create.run(machine_params)
      respond_with machine, serializer: MachineSerializer, location: nil
    end

    def update
      machine = Machine.find(params[:id])
      result = Machines::Update.run(machine_params.merge(machine: machine))
      respond_with result, serializer: MachineSerializer, location: nil
    end

    def destroy
      machine = Machine.find(params[:id])
      machine.destroy!
      render json: {ok: :ok}
    end

    def update_template
      machine = Machine.find(params[:id])
      result = Machines::UpdateTemplate.run(template_params.merge(machine: machine))
      respond_with result, serializer: MachineSerializer, location: nil
    end

    def reboot
      machine = Machine.find(params[:id])
      result = Machines::Reboot.run(machine: machine)
      respond_with result, serializer: MachineSerializer, location: nil
    end

    private

    def machine_params
      params.require(:machine).permit(:model, :serial, :place, :ip)
    end

    def template_params
      params.require(:template).permit(
        :url1,
        :url2,
        :url3,
        :worker1,
        :worker2,
        :worker3,
        :password1,
        :password2,
        :password3,
        :fan,
        :fan_value,
        :freq
      )
    end

  end
end
