class PoolConfig::Bth
  def self.config
    {
      url1: 'lcc.nextblock.ru:55332',
      url2: 'stratum+tcp://stratum.bcc.pool.bitcoin.com:3333',
      url3: '',
      worker1: 'Cem8nbrfTw2SEhFgyvE6KTqiqcc4AeCCvn',
      worker2: 'vidyaevoleg',
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
      id: 'lcc',
      miners: ['M3', 'S9'],
      label: 'Litecoin cash',
      settings: config
    }
  end
end
