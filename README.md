# Hello work Phoenix dockerized project

## Step-by-step to setup development environment

### Create the app
Answer 'Y' or just press enter when you are asked to install dependencies.
``` 
docker run --rm -v $PWD:/app -ti mgarciap/phoenix-dev mix phoenix.new hello_world

cp Dockerfile.local hello_world
cp docker-compose.yml hello_world
cd hello_world
```

### Setup database
Update config/dev.exs and config/test.exs and change the Repo's hostname from localhost to db, which'll resolve to the private ip associated with the linked db container: hostname: "localhost" -> hostname: "db"

```
docker-compose run web mix ecto.create
```

### Run tests

```
docker-compose run web mix test
```

If there is no errors and the output ends like this then you are ok:
```
....

Finished in 0.1 seconds
4 tests, 0 failures
``` 

### Run the Web Server with the Postgres DB
```
docker-compose up
```
