class Machine < ApplicationRecord
  has_one :template, dependent: :destroy
  has_many :stats, dependent: :destroy
  has_many :machine_logs, class_name: 'Machine::Log'
  belongs_to :stat, optional: true
  validates_uniqueness_of :ip, :place, message: "poshel nahooy %{value}"
  validates :place, :model, presence: true
  enum model: {"D3": 0, "L3": 1, "M3": 2, "S9": 3, "A3": 4, "DM22": 5}
  START_IP = '192.168.2.1'
  CHIP_MAP = {
    'M3' => 3,
    'L3' => 4,
    'D3' => 3,
    'S9' => 3
  }

  def url
    "http://#{ip}"
  end

  def save_stat
    Machines::SaveStat.run(machine: self)
  end
end
