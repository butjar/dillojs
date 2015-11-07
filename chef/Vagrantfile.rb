Vagrant.configure(2) do |config|
  config.vm.provision 'shell', inline: <<-EOF
     cp -r /srv/dillojs /opt/
  EOF
end
