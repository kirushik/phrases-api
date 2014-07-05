## What is it?

It is a simple webserver for a Babbel Ruby challenge. It stores phrases in a DB and returns random ones via API

## What features does it have?

 - random phrase retrieval
 - single phrase addition via API call
 - bulk phrases addition via file upload
 - endpoint security (using JWT tokens)
 - database migrations with `rack db:migrate` task
 - all the obvious best practices applicable (API versioning, clean separation of files and modules, Rails-compatible structure, backgound processing of heavy lifting)

## What is the API?

 - GET `/v1/phrases` to recieve current phrases count
 - POST `/v1/phrases?value=…` to add new phrase
 - GET `v1/phrases/random` to retrieve a random phrase

All endpoints return JSON object and use valid HTTP return codes.
All endpoint validate JWT token in the `Authorization:` header to grant access. (Default secret is `"chanegeme"`, which user should certaionly change in `./server.rb`)

## Why is it not in Rails?

To make things fun and challenging.
And to squeeze some speed out of Goliath and EventMachine as well.

## How fast is it?

With four web server processes started (`foreman start -m "web=4, sidekiq=1"`), all proxied by nginx, it shows more than 900 RPS on a medium-class laptop with desktop Linux.
Medium latency depends on a requests concurrency and is under 200ms under all sane conditions.

(54±37 ms per request with 50 concurrent requests, 110±95 ms/req with 100 concurrent requests.)

`ab` command line used to achieve those numbers is like the following:
```bash
ab -H 'Authorization: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMjN9.MtmjkqFhbTTUQpfxw2ceaqrGgIEDKaWAnbWqqnfzaMQ' -n 10000 -c 50 http://localhost:4000/v1/phrases/random
```

## Is it secure?

Security is ensured via JWT token in the `Authorization:` HTTP header. The task to issue (and keep JWT validation secret in a secure way) is up to user.