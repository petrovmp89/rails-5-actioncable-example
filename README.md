# Rails 5 actioncable example

* Ruby version
  - 2.4.1
* Rails version
  - 5.1.4
* System dependencies
  - redis-server
  - mongodb
  - nodejs
* How to run app locally

  `whenever --update-crontab`

  `rails s`
* How to run app container

  `docker build . -t example_app_image`

  `docker run -p 0.0.0.0:3000:3000 -it --name example_app_container example_app_image`
