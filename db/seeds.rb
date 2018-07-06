
users = [
  {
    email: 'admin@nextblock.ru',
    password: '12345678'
  },
  {
    email: 'alexey@nextblock.ru',
    password: 'sdsafdsfsd',
  },
  {
    email: 'andrey@nextblock.ru',
    password: 'dfdsfdsdf',
  },
  {
    email: 'anton@nextblock.ru',
    password: 'dsd34fdf'
  },
  {
    email: 'artem@nextblock.ru',
    password: '42344fdsd',
  },
  {
    email: 'valeriy@nextblock.ru',
    password: 'sa3543ddf',
  },
  {
    email: 'volkov@nextblock.ru',
    password: 'sddr9080',
  },
  {
    email: 'maxim@nextblock.ru',
    password: 'jkjokpkll'
  }
]
users.each {|attrs| User.create!(attrs)}
