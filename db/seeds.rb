Machine.destroy_all

machine = Machine.create!(
  model: 0,
  ip: '192.168.0.1:1234',
  serial: '111111111',
  place: '1-2-2'
)
template = Template.create!(
  url1: 'b2x.nextblock.ru',
  worker1: 'worker',
  password1: 'x',
  url2: 'b2x.nextblock.ru',
  worker2: 'worker',
  password2: 'x',
  url3: 'b2x.nextblock.ru',
  worker3: 'worker',
  password3: 'x',
  fan: true,
  fan_value: 101,
  machine: machine
)
