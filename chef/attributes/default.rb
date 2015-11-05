# encoding: UTF-8

default['dillojs']['home'] = '/opt/dillojs'
default['dillojs']['api']['home'] = "#{default['dillojs']['home']}/api"
default['dillojs']['web']['home'] = "#{default['dillojs']['home']}/web"
default['dillojs']['npm']['packages']['global'] = [ 'bower', 'brunch' ]
default['dillojs']['nginx']['root_dir'] = '/usr/share/nginx/www/'

default['nodejs']['install_method'] = 'binary'
default['nodejs']['npm']['install_method'] = 'binary'
default['nodejs']['npm']['user'] = 'dillo'
default['nodejs']['npm']['group'] = 'dillos'
