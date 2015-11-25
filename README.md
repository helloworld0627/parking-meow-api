# parking-meow-api

# Local
- Postgres is installed
- run "rails s" to launch the service locally

# Heroku
- First time DB migration: heroku run rake db:migrate
- Run API Request Scheduler: heroku run rails runner ApiRequestSchedule.etl