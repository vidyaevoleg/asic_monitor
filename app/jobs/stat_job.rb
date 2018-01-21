class StatJob < ApplicationJob
  queue_as :default

  def perform(machine_id)
    machine = Machine.find(machine_id)
    machine.save_stat
  end
end
