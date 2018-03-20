class PoolConfig::Dash
  def self.config
    {
      url1: 'dash.nextblock.ru:54332',
      url2: 'stratum+tcp://thecoin.pw:3807',
      url3: '',
      worker1: 'XjiW8i7LrW8vzp1oqt8JPe9vqyFZxPuVdQ',
      worker2: 'boris_urich.boris_urich',
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
      id: 'dash1',
      miners: ['D3'],
      label: 'Dash',
      settings: config
    }
  end
end
