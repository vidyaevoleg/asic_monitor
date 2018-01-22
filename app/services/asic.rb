require_relative 'asic'

class Asic
  attr_reader :machine

  def self.[](machine)
    klass = Asic.const_get(machine.model).new(machine)
  end

  def initialize(machine)
    @machine = machine
  end

  def reboot

  end


  def update
    self.class.const_get('Update').call(machine)
  end

  def info
    @info ||= self.class.const_get('Info').new(machine).info
  end
end
