# Requirement

* Vagrant
* Chef
* knife-solo
* librarian-chef
* vagrant-digitalocean
* digital_ocean.box
* vagrant-omnibus


# Prepare following files

    $ git submodule init
    $ git submodule update

* src/cakephp-2.5.5
* src/secrets/data_bag_key
* src/digitalocean/digitalocean_token.rb


# Prepare cookbooks

    $ cd chef
    $ librarian-chef install
