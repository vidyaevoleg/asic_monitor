class PoolConfig::Bth
  def self.config
    {
      url1: 'stratum+tcp://stratum.bcc.pool.bitcoin.com:3333',
      url2: 'dgb-sha256.nextblock.ru:52332',
      url3: '',
      worker1: 'vidyaevoleg',
      worker2: 'DFVs2xyc1P6CEyhed5Ya3fcHCwuqWu83Sm',
      worker3: '',
      password1: 'x',
      password2: 'xxx',
      password3: '',
      fan: false,
      fan_value: '',
      freq: 0
    }
  end

  def self.as_json
    {
      id: 'bth',
      miners: ['M3', 'S9'],
      label: 'Bitcoin cash',
      settings: config
    }
  end
end
