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
* src/cakephp-2.5.5/app/Plugin/DebugKit
* src/cakephp-2.5.5/app/Plugin/Phpunit

# Prepare the application source

    $ cd {menu_search_env}/src/cakephp-2.5.5
    $ git checkout master
    $ git submodule init
    $ git submodule update

# Prepare the Phpunit source

    $ cd {menu_search_env}/src/cakephp-2.5.5/app
    $ Console/cake Phpunit.Phpunit install

（略）
Installing PHPUnit 3.7 ...
1. /app/Vendor/
2. /vendors/
Select VENDOR path to install into (q/1/2)
[q] > 1

* インストール場所を聞かれるので、「app/Vendor」を選択

# Prepare cookbooks

    $ cd {menu_search_env}/chef
    $ librarian-chef install
