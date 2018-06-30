class MachinesController < ApplicationController
  def index
    db_machines = Machine.eager_load(:stat, :template).order(id: :desc).all
    machines = json_collection.new(db_machines, each_serializer: ::MachineSerializer)
    gon.machines = machines
    gon.models = Machine.models.keys
    gon.configs = PoolConfig.all
  end

  def show
    @machine = Machine.includes(:template, :machine_logs).find(params[:id])
    stats = Stat.includes(:machine).order(id: :desc).where(machine: @machine).limit(200)
    gon.stats = json_collection.new(stats, each_serializer: StatSerializer)
    gon.chips = Machine::CHIP_MAP[@machine.model]
    @logs = @machine.machine_logs.order(id: :desc).limit(100)
  end
end
