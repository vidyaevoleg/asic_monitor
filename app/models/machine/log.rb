class Machine::Log < ApplicationRecord
  belongs_to :machine

  def date
    created_at&.strftime("%H:%M %d/%m")
  end
end
