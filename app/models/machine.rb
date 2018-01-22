class Machine < ApplicationRecord
  has_one :template, dependent: :destroy
  has_many :stats, dependent: :destroy
  validates :ip, :place, uniqueness: true
  validates :place, :model, presence: true
  enum model: {"D3": 0, "L3": 1, "M3": 2, "S9": 3}
  START_IP = '192.168.2.1'

  def url
    "http://#{ip}"
  end

  def save_stat
    Machines::SaveStat.run(machine: self)
  end
end
