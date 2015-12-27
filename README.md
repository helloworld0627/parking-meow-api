# parking-meow-api
- A simple Rest service that get parking information using gov api

# Usage
Retrieve parking where the rate lower or equal to by given price
- /parking_lots?rte_1hr=price 
- /parking_lots?rte_2hr=price
- /parking_lots?rte_3hr=price
- /parking_lots?rte_allday=price

Retrieve parking where opens in given days
- /parking_lots?hrs_monfri=true 
- /parking_lots?hrs_sat=true
- /parking_lots??hrs_sun=true

# Local
- Postgres is installed
- run "rails s" to launch the service locally

# Heroku
- First time DB migration: heroku run rake db:migrate
- Run API Request Scheduler: heroku run rails runner ApiRequestSchedule.etl
- To reset the DB: heroku pg:reset DATABASE
