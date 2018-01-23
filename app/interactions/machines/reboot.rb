module Machines
  class Reboot < ::ApplicationInteraction
    object :machine

    def to_model
      machine.reload
    end

    def execute
      begin
        output = Asic[machine].reboot
      rescue
        errors.add(:machine, "#{machine.ip} didn't respond")
      end
      self
    end
  end
end
