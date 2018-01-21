class PoolConfig::Ltc
  def self.config
    {
      url1: 'ltc.nextblock.ru:51342',
      url2: 'stratum+tcp://us.litecoinpool.org:3333',
      url3: '',
      worker1: 'LZ4ywsThyj5pMBr2xZi6Lq4HDj8W9CmJkR',
      worker2: 'pmiminingltc.18',
      worker3: '',
      password1: 'x',
      password2: '18',
      password3: '',
      fan: true,
      fan_value: '80',
      freq: 400
    }
  end
end
