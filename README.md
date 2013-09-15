IRC Blinky
==========
IRC Blinky is a quick Ruby application that a few friends and I wrote over the weekend.

It's function is to flash LEDs on a Raspberry Pi (*or similar) board when you've been highlighted over IRC.

Currently it depends on a few gems, Ponder for IRC communications and PiPiper for GPIO communication.

To run (on a bare Raspberry Pi w/ Rasbian):
```
$ sudo apt-get install ruby1.9.1 ruby1.9.1-dev
$ sudo gem install bundler
$ cd irc-blinky
$ sudo bundle install
$ ## Keep in mind, GPIO requires root!
$ sudo ruby app.rb
```
