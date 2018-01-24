class MachinesController < ApplicationController
  def index
    db_machines = Machine.includes(:template, :stats).order(id: :desc).all
    machines = json_collection.new(db_machines, each_serializer: ::MachineSerializer)
    gon.machines = machines
    gon.models = Machine.models.keys
    gon.configs = PoolConfig.all
  end

  def show
    @machine = Machine.includes(:template).find(params[:id])
    stats = Stat.includes(:machine).order(id: :desc).where(machine: @machine).limit(200)
    gon.stats = json_collection.new(stats, each_serializer: StatSerializer)
    gon.chips = Machine::CHIP_MAP[@machine.model]
  end
end
