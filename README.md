# Test Task

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

  `docker build . -t test_task_image`

  `docker run -p 0.0.0.0:3000:3000 -it --name test_task_container test_task_image`
