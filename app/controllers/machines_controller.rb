class MachinesController < ApplicationController
  def index
    db_machines = Machine.includes(:template, :stats).order(id: :desc).all
    machines = json_collection.new(db_machines, each_serializer: ::MachineSerializer)
    gon.machines = machines
    gon.models = Machine.models.keys
    gon.configs = PoolConfig.all
  end
end
