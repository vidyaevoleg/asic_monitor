module Machines
  class UpdateAsic < ::ApplicationInteraction

    object :machine, class: Machine

    def to_model
      machine.reload
    end

    def execute
      remote = Asic[machine]
      begin
        remote.update
      rescue
        errors.add(:machine, "#{machine.ip} didn't respond")
      end
      self
    end
  end
end
