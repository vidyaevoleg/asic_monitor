module Machines
  class UpdateTemplate < ::ApplicationInteraction
    object :machine, class: Machine
    string :url1
    string :url2, default: nil
    string :url3, default: nil
    string :worker1
    string :worker2, default: nil
    string :worker3, default: nil
    string :password1
    string :password2, default: nil
    string :password3, default: nil
    boolean :fan, default: false
    string :fan_value, default: nil
    integer :freq, default: 400

    def execute
      template.update(inputs.except(:machine))
      errors.merge!(template.errors)
      if valid?
        compose(UpdateAsic, machine: machine.reload)
      end
      self
    end

    def to_model
      machine.reload
    end

    private

    def template
      @template = machine.template || Template.create(machine: machine)
    end
  end
end
