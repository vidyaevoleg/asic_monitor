module Machines
  class UploadConfig < ::ApplicationInteraction
    object :file, class: ActionDispatch::Http::UploadedFile

    def execute
      known_machines = Machine.where(serial: asics.map {|a| a[:serial]})
      unknown_machines = Machine.where.not(id: known_machines.pluck(:id))
      unknown_machines.destroy_all

      asics.each do |asic|
        known_machine = Machine.find_by(serial: asic[:serial])
        if known_machine
          known_machine.update(asic)
          unless known_machine.valid?
            errors.merge!(known_machine.errors)
            return false
          end
        else
          ip_machine = Machine.find_by(ip: asic[:ip])
          ip_machine.destroy! if ip_machine
          form = Machines::Create.run(asic)
          if form.invalid?
            errors.merge!(form.errors)
            return false
          end
        end
      end
      self
    end

    private

    def content
      @content ||= file.read
    end

    def asics
      @asics ||= begin
        content.split('server=dhcp1').each_with_index.map do |line, ind|
          if line.include?('address=') && line.include?('userid=') && line.include?('mac-address=') && line.include?('comment=') && line.include?('model=')
            {
              ip: line.split('add address=').last.split(' ').first,
              serial: line.split('mac-address=').last.split(' ').first,
              place: line.split('comment=').last.split(' ').first,
              model: line.split('model=').last.split(' ').first,
              user_id: line.split('userid=').last.split(' ').first
            }
          end
        end.compact
      end
    end
  end
end
