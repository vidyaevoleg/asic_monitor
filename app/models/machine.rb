class Machine < ApplicationRecord
  has_one :template, dependent: :destroy
  validates :ip, :place, uniqueness: true
  validates :place, :model, presence: true
  enum model: {"D3": 0, "L3": 1, "M3": 2, "S9": 3}
  START_IP = '192.168.2.1'

  def url
    "http://#{ip}"
  end

  def remote
    Asic.const_get(model).new(self)
  end
end
