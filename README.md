# Beenshortened API


A Ruby on Rails API to shorten URLs


## Overview


This API uses a variation of libraries to generate the shortest possible
length URL you can find, for that it uses an algorithm which is based in the
most readable URLs generation taking in mind that you may share them with your
friends or coworkers.


#### Shortening algorithm


The process to build the short URLs starts using a autoincrement number
which can be stored in memory and increment it every time a new
short URL is generated, but for persistence, the API will use
the Postgres autoincrement from the ShortLink table where the shortened
URLs will be stored, and every time a new request is executed the API will
perform a query to the database and get the last id and then convert it to base62
which is the alphabet from a..z and the uppercase A..Z, also the numbers from 0..9
is possible to use more characters but for readability is better to use just those
then after convert it to base62 is stored in the database with its due link.


## Getting Started


### Prerequisites


This app uses `PostgreSQL 10` database was built with `Ruby 2.3.3` and `Rails 4.1`.



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


## Running tests
All the entry points have a test if you want to modify this and
run some tests or add some more this API uses `Rspec` and the command
to run all the tests is:


```bash
rspec
```



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


#### cURL examples:
```bash
curl -d "url=https://www.google.com" -X POST http://localhost:3000/api/v1/link_shortener
```
```bash
curl http://localhost:3000/api/v1/link_shortener/top
```
```bash
curl http://localhost:3000/api/v1/link_shortener/1
```
## Pending features



- Authorization
- Analytics
- Better error handling



## License
[MIT](https://choosealicense.com/licenses/mit/)