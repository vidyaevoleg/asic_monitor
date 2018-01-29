require 'telegram/bot'

class Notifier
  class << self
    def shut_down(machine)
      write("machine #{machine.model} on place #{machine.place} shuw down")
    end

    def unsuccessfull(machine, need_reboot = false)
      write("machine #{machine.model} on place #{machine.place} rebooted")
    end

    def temp_up(machine, rebooted = false)
      write("machine #{machine.model} on place #{machine.place} temp over #{Asic[machine].max_temp} #{', machine rebooted' if rebooted}")
    end

    def hashrate_down(machine, rebooted = false)
      write("machine #{machine.model} on place #{machine.place} hashrate lower then  #{machine.stats.last.hashrate} #{', machine rebooted' if rebooted}")
    end

    def write(message)
      token = '513352298:AAET6A2tCe-dc5eVXRizuo80o0OtzH8RXl8'
      chat_id = '-265831084'#'-254088467'
      Telegram::Bot::Client.run(token) do |bot|
        bot.api.send_message(chat_id: chat_id, text: message)
      end
    end
  end
end
