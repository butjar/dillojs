# DilloJS
Simple CRUD application for demonstration of infrastructure testing.

## Requirements
To run the tests against the infrastructure there are some requirements, which
will be listed in this section.

### Ruby
You need a working ruby environment for running the test suite. Have a look at
[rvm](https://rvm.io/) or [rbenv](https://github.com/sstephenson/rbenv) to get
your ruby environment working.

The dependencies are managed in Gemfiles. To install the dependencies you need
to install [bundler](http://bundler.io/):`gem install bundler`

### Vagrant
For running the tests on kitchen with the vagrant driver, you need to install
[virtualbox](https://www.virtualbox.org/) and
[vagrant](https://www.vagrantup.com/).

### ChefDK
To converge the node with [chef\_solo](https://docs.chef.io/chef_solo.html)
install the [chefDK](https://downloads.chef.io/chef-dk/).

### Docker
The application is also dockerized. For running the application with
docker-compose under OS X or Windows install the
[docker-toolbox](https://www.docker.com/docker-toolbox).

## Running the tests
### Kitchen
#### Buser
Setup the vagrant node:
- Go to the chef directory: `cd chef`
- Install the dependencies with bundler: `bundle install`
- Create the vagrant node and provision it: `kitchen converge`

Now you can run the test suite with
[busser](https://github.com/test-kitchen/busser): `kitchen verify`

For more details check the [kitchen documentation](http://kitchen.ci/).

#### SSH
You can also run the [serverspec](http://serverspec.org/) tests over SSH.
The vagrant instance must be running:
- Go to the chef directory: `cd chef`
- Install the bundle: `bundle install`
- Converge the node: `kitchen converge`

Now you can run the tests:
- Go back to the root directory of the project.
- Go to the test directory: `cd test`
- Install the dependencies with bundler: `bundle install`
- Run the test suite: `rake spec`

### Docker
Run the tests against the dockerized application (only a
[test](/test/spec/docker/nginx_spec.rb) for nginx right now):
- Start the application with docker-compose in the root directory: `docker-compose up`
- go to the test directory: `cd test`
- run the tests against the nginx container: `DRIVER=docker rake spec`
