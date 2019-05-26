# MongoDB Configuration

### TASK

The task was to create a recipe that installs and configures this cookbook correctly to pass all ChefSpec and Inspec tests.

The following ChefSpec tests were setup and passed:
- Create a mongod.conf file in /etc/mongod.conf
- Create a mongod.service file in /lib/systemd/system/mongod.service
- MongoDB service should be enabled
- MongoDB service should be started

The following InSpec tests were setup and passed:
- MongoDB is running
- MongoDB is enabled
- MongoDB is listening on 27017 by default
- MongoDB is listening on 0.0.0.0 by default

