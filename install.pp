# Install ms odbc on redaht 6

exec { 'repo' :
  path => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  cwd  => '/',
  command => 'curl https://packages.microsoft.com/config/rhel/6/prod.repo > /etc/yum.repos.d/mssql-release.repo',
  unless => 'test -f /etc/yum.repos.d/mssql-release.repo',
}

package { ['unixODBC-utf16', 'unixODBC-utf16-devel'] :
  ensure => absent,
  before => Exec[ 'repo' ],
}

exec { 'install' :
  require => Exec[ 'repo' ],
  path => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  cwd  => '/',
  environment => 'ACCEPT_EULA=Y',
  command => 'yum install  -y mssql-tools unixODBC-devel',
}

