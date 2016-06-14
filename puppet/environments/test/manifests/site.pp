class {'::apt':
  always_apt_update => true
}

apt::source { 'erlang-solutions':
  location    => 'http://packages.erlang-solutions.com/debian',
  repos       => 'contrib',
  key         => 'D208507CA14F4FCA',
  key_server  => 'pgp.mit.edu',
  include_src => false,
}

package { ['erlang', 'elixir', 'libexpat1-dev', 'git', 'ruby', 'ruby-dev']:
  ensure => latest,
  require => Apt::Source['erlang-solutions'],
}

package {'fpm':
  ensure => latest,
  provider => gem,
  require => Package['ruby-dev'],
}
