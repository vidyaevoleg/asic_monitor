class StatSerializer < ApplicationSerializer
  attributes :temparatures, :id, :hashrate, :success, :active, :blocks, :place, :url, :ip, :model, :time

  def ip
    machine.ip
  end

  def place
    machine.place
  end

  def model
    machine.model
  end

  def url
    machine.url
  end

  def machine
    @machine ||= object.machine
  end


  def time
    object.created_at.strftime("%H:%M %d-%m-%Y")
  end
end
