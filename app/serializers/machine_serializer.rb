class MachineSerializer < ApplicationSerializer
  attributes :ip,
    :model,
    :id,
    :place,
    :serial,
    :url,
    :hashrate,
    :temparatures,
    :success,
    :active,
    :time,
    :blocks_count

  has_one :template, serializer: TemplateSerializer do
    object.template
  end

  def stat
    @_stat = object.stats.order(id: :desc).first
  end

  def temparatures
    stat&.temparatures
  end

  def active
    stat&.active
  end

  def success
    stat&.success
  end

  def hashrate
    stat&.hashrate
  end

  def time

    stat&.created_at&.strftime("%H:%M %d:%m")
  end

end
