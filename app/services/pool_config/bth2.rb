class PoolConfig::Bth2
  def self.config
    {
      url1: 'stratum+tcp://stratum.bcc.pool.bitcoin.com:3333',
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
      id: 'bth2',
      miners: ['M3', 'S9'],
      label: 'Bitcoin cash (родной)',
      settings: config
    }
  end
end
