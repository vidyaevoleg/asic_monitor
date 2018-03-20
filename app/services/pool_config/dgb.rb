class PoolConfig::Dgb
  def self.config
    {
      url1: 'dgb-sha256.nextblock.ru:52332',
      url2: 'stratum+tcp://thecoin.pw:3807',
      url3: '',
      worker1: 'DEmdJS8BGGHyBU8KzrwfV2sGstaGJRzDAC',
      worker2: 'boris_urich.boris_urich',
      worker3: '',
      password1: 'x',
      password2: 'xxx',
      password3: '',
      fan: false,
      fan_value: '',
      freq: 400
    }
  end

  def self.as_json
    {
      id: 'dgb',
      miners: ['M3', 'S9'],
      label: 'DGB',
      settings: config
    }
  end
end
