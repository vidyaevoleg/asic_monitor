module Machines
  class Update < ::ApplicationInteraction
    object :machine, class: Machine
    string :model
    string :serial, default: nil
    string :place

    validate do
      unless Machine.models.keys.include?(model)
        errors.add(:model, :invalid)
      end
    end

    def execute
      machine.update(inputs.except(:machine))
      errors.merge!(machine.errors)
      self
    end

    def to_model
      machine.reload
    end

  end
end
