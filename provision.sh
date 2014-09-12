#!/usr/bin/env sh
cd $HOME
sudo apt-get update
sudo apt-get install tcl8.5-dev -y
wget http://download.redis.io/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
rm -rf redis-stable.tar.gz
cd redis-stable
make
sudo make install
# make test
sudo mkdir /etc/redis
sudo mkdir /var/redis
sudo mkdir /var/redis/6379
echo "bind 0.0.0.0" | tee -a redis.conf
echo "daemonize yes" | tee -a redis.conf
echo "logfile /var/log/redis_6379.log" | tee -a redis.conf
echo "pidfile /var/run/redis_6379.pid" | tee -a redis.conf
echo "dir /var/redis/6379" | tee -a redis.conf
echo "loglevel warning" | tee -a redis.conf
sudo cp redis.conf /etc/redis/6379.conf
sudo cp utils/redis_init_script /etc/init.d/redis_6379
sudo update-rc.d redis_6379 defaults
sudo /etc/init.d/redis_6379 start
sleep 5
cat /var/log/redis_6379.log
