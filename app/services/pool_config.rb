class PoolConfig
  attr_reader :id, :address, :currency

  def self.all
    url = 'http://nextblock.ru/api/pools'
    pools = JSON.parse(RestClient.get(url).body) rescue []
    pools.map {|pool| new(pool).as_json}
  end

  def initialize(options={})
    @id= options["id"]
    @currency = options["currency"]
    @address = options["address"]
  end

  def miners
    if id == 'ltc1'
      ['L3']
    elsif id == 'btc2x1'
      ['D3']
    elsif id == 'dgb_sha256'
      ['M3', 'S9']
    elsif id == 'dgb_scrypt'
      ['L3']
    else
      []
    end
  end

  def label
    if id == 'ltc1'
      'Litecoin'
    elsif id == 'btc2x1'
      'Segwit2x'
    elsif id == 'dgb_sha256'
      'DGB sha256'
    elsif id == 'dgb_scrypt'
      'DGB scrypt'
    else
      ''
    end
  end

  def settings
    if id == 'ltc1'
      PoolConfig::Ltc.config
    elsif id == 'btc2x1'
      PoolConfig::B2x.config
    elsif id == 'dgb_sha256'
      PoolConfig::Dgb_sha256.config
    elsif id == 'dgb_scrypt'
      PoolConfig::Dgb_scrypt.config
    else
      {}
    end
  end

  def as_json
    {
      id: id,
      miners: miners,
      label: label,
      settings: settings
    }
  end

end
