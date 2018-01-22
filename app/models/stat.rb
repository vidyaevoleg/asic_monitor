class Stat < ApplicationRecord
  serialize :temparatures, Array
  belongs_to :machine
  INVALID = {
    success: false,
    active: false,
    temparatures: [],
    blocks: 0,
    hashrate: 0
  }

  def created_at
    super.in_time_zone("Moscow")
  end
end
