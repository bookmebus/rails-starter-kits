# README

## Puma dev server with test domain
The project uses puma-dev server to setup local test domain. The default test domain is https://rails-starter-kits.test ( set up in ENV['ALLOW_HOST_DEV']). By default puma-dev server create a symlink for your project directory name with a symlink under ~/.puma-dev/. this symlink will also be used as the the domain name thus your directory name with [.test] top level domain name, thus

```
directory_name = rails-starter-kits
top_level_domain = .test
ENV['ALLOW_HOST_DEV'' > rails-starter-kits.test
```
ALLOW_HOST_DEV env var is required because we need to whitelist the domain in rails development environment.

### Install Puma dev server
The installation instruction can be found here: https://github.com/puma/puma-dev#install--setup

### Setup puma dev for rails project
```
# cd to the root of the rails project
cd rails-starter-kits

# to install directory
puma-dev -install

# to uninstall
puma-dev -uninstall

# display log 
tail -f ~/Library/Logs/puma-dev.log

# restart the server
touch tmp/restart.txt
```