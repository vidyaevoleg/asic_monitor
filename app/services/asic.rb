require_relative 'asic'

class Asic
  attr_reader :machine

  def initialize(machine)
    @machine = machine
  end

  def update_config
    Machines::UpdateAsic.run(machine: machine)
  end

  def info
    info_object = machine.remote.class.const_get('Info').new(machine)
    @info ||= info_object.info
  end
end
