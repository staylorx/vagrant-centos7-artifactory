Package {
   allow_virtual => true,
}

package { 'wget':
  provider => 'yum',
  name => 'wget',
  ensure => installed
}

package { 'curl':
  provider => 'yum',
  name => 'curl',
  ensure => installed
}

package { 'ruby-augeas':
  provider => 'yum',
  name => ['ruby-augeas'],
  ensure => installed
}

package { 'augeas':
  provider => 'yum',
  name => ['augeas'],
  ensure => installed
}

package { 'unzip':
  provider => 'yum',
  name => 'unzip',
  ensure => installed
}

package { 'java-openjdk8':
  provider => 'yum',
  name => 'java-1.8.0-openjdk-devel',
  ensure => installed
}

service { 'firewalld-stop':
  name => 'firewalld',
  stop => 'true',
  enable => 'false'
}

augeas { 'etc-hosts4':
  context => "/files/etc/hosts",
  changes => [ 
    "set *[ipaddr='127.0.0.1']/canonical artifactory.taybiz.local",
    "ins alias after *[ipaddr='127.0.0.1']/canonical",
    "set *[ipaddr='127.0.0.1']/alias[1] artifactory"
  ],
  onlyif => "match *[ipaddr='127.0.0.1']/alias size == 3"
}

augeas { 'etc-hosts6':
  context => "/files/etc/hosts",
  changes => [ 
    "set *[ipaddr='::1']/canonical artifactory.taybiz.local",
    "ins alias after *[ipaddr='::1']/canonical",
    "set *[ipaddr='::1']/alias[1] artifactory"
  ],
  onlyif => "match *[ipaddr='::1']/alias size == 3"
}


