class Machine < ApplicationRecord
  has_one :template, dependent: :destroy
  has_many :stats, dependent: :destroy
  belongs_to :stat
  validates :ip, :place, uniqueness: true
  validates :place, :model, presence: true
  enum model: {"D3": 0, "L3": 1, "M3": 2, "S9": 3}
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
