class MachinesController < ApplicationController
  def index
    db_machines = Machine.includes(:template).order(id: :desc).all
    machines = json_collection.new(db_machines, each_serializer: ::MachineSerializer)
    gon.machines = machines
    gon.models = Machine.models.keys
    gon.configs = PoolConfig.all
  end


  def reboot
    machine = Machine.find(params[:id])
    Machines::UpdateAsic.run(machine: machine)
    redirect_to :back
  end
end
