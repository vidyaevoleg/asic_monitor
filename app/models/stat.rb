class Stat < ApplicationRecord
  serialize :temperatures, Array
  INVALID = {
    success: false,
    active: false,
    temparatures: [],
    blocks: 0,
    hashrate: 0
  }
end
