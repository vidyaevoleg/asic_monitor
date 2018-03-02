class PoolConfig
  attr_reader :id, :address, :currency

  def self.all
    custom
  end

  def self.custom
    [
      PoolConfig::B2x.as_json,
      PoolConfig::Bth.as_json,
      PoolConfig::Bth2.as_json,
      PoolConfig::Dash.as_json,
      PoolConfig::Ltc.as_json,
      PoolConfig::Dgb.as_json,
      PoolConfig::Lcc.as_json,

    ]
  end
end
