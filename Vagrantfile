require 'yaml'

VAGRANTFILE_API_VERSION = "2"

# read the site configuration yaml file
SITE = YAML.load_file('site.yml')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |cfg|

  cfg.vm.box = 'CentOS-6.4-x86_64'
  cfg.vm.box_url = 'http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box'
  
  # iterate the services sequence and create vms
  SITE['services'].each do |svc|

    general = svc['general']
    network = svc['network']
    system = svc['system']
    pkgs = svc['pkgs']

    cfg.vm.define general['name'] do |svcdef|
      svcdef.vm.network :private_network, ip: network['ip']

      svcdef.vm.provider :virtualbox do |vbox|
        vbox.memory = system['memory']
        vbox.cpus = system['cpus']
      end

      svcdef.vm.provision :shell do |shell|
        shell.path = 'pkgs/admin/setup.sh'
        shell.args = "/vagrant/pkgs/admin"
      end
      
      svcdef.vm.provision :shell do |shell|
        shell.path = 'pkgs/java/setup.sh'
        shell.args = "/vagrant/pkgs/java"
      end

      if pkgs
          pkgs.each do |pkg|
            svcdef.vm.provision :shell do |shell|
              if pkg.class == Hash
                pkg_name = pkg.keys[0]
                shell.path = "pkgs/#{pkg_name}/setup.sh"
                shell.args = "/vagrant/pkgs/#{pkg_name} #{pkg[pkg_name]}"
              else
                shell.path = "pkgs/#{pkg}/setup.sh"
                shell.args = "/vagrant/pkgs/#{pkg}"
              end
            end
          end
      end

    end

  end

end