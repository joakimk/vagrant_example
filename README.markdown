This is an example of how to use vagrant to setup a rails development environment with REE and Passenger.

Tested with:
----
Vagrant 0.7.2 and VirtualBox 4.0.2.

Usage:
----

Download and install VM:

   gem install vagrant -v 0.7.2 

   # This takes about 10-20 minutes
   vagrant up

View the app:

   echo "10.5.5.5 app.dev" | sudo tee -a /etc/hosts
   open "http://app.dev/users"

Login and run tests:

   vagrant ssh
   rake
