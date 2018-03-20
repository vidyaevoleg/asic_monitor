class PoolConfig::Bth
  def self.config
    {
      url1: 'bth.nextblock.ru:53332',
      url2: 'stratum+tcp://stratum.bcc.pool.bitcoin.com:3333',
      url3: '',
      worker1: '1Pkr1VoZFa5D8GcyLcq7FGvdjqt2AN51YP',
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
      id: 'bth',
      miners: ['M3', 'S9'],
      label: 'Bitcoin cash',
      settings: config
    }
  end
end
