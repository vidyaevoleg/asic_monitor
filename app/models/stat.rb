class Stat < ApplicationRecord
  serialize :temperatures, Array
  INVALID = {
    valid: false,
    temparatures: [],
    blocks: 0,
    hashrate: 0
  }
end
