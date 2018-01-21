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
end
