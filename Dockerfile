FROM ubuntu:16.04

RUN apt-get update \
&& apt-get install -y software-properties-common curl nodejs nodejs-legacy npm\
&& apt-get update

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" » /etc/profile

# Install mongo
RUN bash -c 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6'
RUN bash -c 'echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list'
RUN apt-get update && apt-get install -y mongodb-org

# Install redis
RUN apt-get install -y redis-server

# Install yarn
RUN bash -c 'npm install yarn -g'

# Install rvm
RUN bash -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
RUN bash -c '\curl -sSL https://get.rvm.io | bash'
RUN curl -L https://get.rvm.io | bash -s stable

RUN bash -c 'source /usr/local/rvm/scripts/rvm; rvm install ruby-2.4.1'
RUN bash -c 'source /usr/local/rvm/scripts/rvm; gem install bundler'

# Copy gemfiles
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN echo 'gem "tzinfo-data"' >> /app/Gemfile

# Install gems
RUN bash -c 'source /usr/local/rvm/scripts/rvm; cd /app && bundle install'

# Copy app
ADD . /app
COPY ./config/mongoid.yml.example /app/config/mongoid.yml
RUN echo 'gem "tzinfo-data"' >> /app/Gemfile

# Install packages
RUN bash -c 'cd /app && yarn install'

# Redirect logs
RUN bash -c 'touch /app/log/development.log'
RUN ln -sf /dev/stdout /app/log/development.log

# Create mongo directory
RUN mkdir -p /data/db

EXPOSE 3000
ENTRYPOINT "/app/run.sh"
