#!/usr/bin/env bash
env | grep _ >> /etc/environment
/etc/init.d/cron start
/etc/init.d/redis-server start
mongod --syslog &
source /usr/local/rvm/scripts/rvm && cd /app && rvm use ruby-2.4.1 && whenever --update-crontab && rails s
