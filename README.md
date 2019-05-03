# Beenshortened API


A Ruby on Rails API to shorten URLs



## Overview


This API uses a variation of libraries to generate the shortest possible
length URL you can find, for that it uses an algorithm which is based in the
most readable URLs generation taking in mind that you may share them with your
friends or coworkers, this implementation uses a base62 conversion that takes the
most common characters in the alphabet and uses them as a key value dictionary
and an autoincrement in this case the database id to convert it into
base62 and then store it with the long URL.


## Getting Started


This app uses `postgreSQL` database and `rspec` to test the endpoints
also is currently configured to run in `Heroku`, and was built with
`rails 4.1`.


## Installation


First of all, you will need to install Ruby on Rails so you can follow this [guide](http://installrails.com/).
and for the database, you can follow this [tutorial](http://postgresguide.com/setup/install.html) for any platform
Then run the bundle installation:
```bash
bundle install
```


after that you will have all the dependencies installed, the next thing will be run the
database structure creation commands:


```bash
rake db:create db:migrate
```


and if you want to have some starting data you can use the seed with this simple command:


```bash
rails db:seed
```


after all those boring commands you can start the next section.


## Usage


To start the application just type this command:
```bash
rails s
```
You will find three entries in this endpoint:


First one to create short URLs
```ruby
POST /api/v1/link_shortener
```
You will need to provide a `body` with a `url` with the original URL


This return the original URL and only requires the previously created slug
```ruby
GET /api/v1/link_shortener/:slug
```


and finally the top 100 most visited links
```ruby
GET /api/v1/link_shortener/top
```


## Pending features


- Authorization
- Analytics
- Better error handling


## License
[MIT](https://choosealicense.com/licenses/mit/)