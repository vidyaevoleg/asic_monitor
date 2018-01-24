class StatSerializer < ApplicationSerializer
  attributes :temps, :id, :hashrate, :time, :chips

  def temps
    object.temparatures
  end

  def time
    object.created_at
  end

  def chips
    Asic[object.machine].chips
  end
end
