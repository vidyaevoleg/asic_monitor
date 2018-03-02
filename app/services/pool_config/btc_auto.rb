class PoolConfig::BtcAuto
  def self.config
    {
      url1: 'stratum+tcp://profit.pool.bitcoin.com:3333',
      url2: 'dgb-sha256.nextblock.ru:52332',
      url3: '',
      worker1: 'vidyaevoleg',
      worker2: 'DFVs2xyc1P6CEyhed5Ya3fcHCwuqWu83Sm',
      worker3: '',
      password1: 'x',
      password2: 'x',
      password3: '',
      fan: false,
      fan_value: '',
      freq: 0
    }
  end

  def self.as_json
    {
      id: 'bthauto',
      miners: ['M3', 'S9'],
      label: 'Btc/Bth (auto)',
      settings: config
    }
  end
end
