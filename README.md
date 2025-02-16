# Post app

App to generate posts and ratings

## Installation

Run in your console next commands:

```bash
bundle
yarn install
rails assets:precompile
rails db:prepare
```

## Usage

Enter http://localhost:3000/ to see root page with posts
Enter http://localhost:3000/posts/new to create a new post

Each post you can rate choosing user and rating value from 1 to 5.

**Constraints**
1. User can't rate their own posts.
2. User can't rate one post twice

## curl requests
Send requests using curl bash

**New posts**

Request example:

```bash
curl --location 'http://localhost:3000/posts' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data '{
    "post": {
        "title": "New post title",
        "body": "Always two there are, no more, no less. A master and an apprentice.",
        "ip": "112.249.201.113",
        "user_attributes": {
            "login": "Simon"
        }
    }

}'
```

Response example

```json
{
    "status": "ok",
    "user": {
        "id": 129,
        "login": "Simon",
        "created_at": "2025-02-16T09:27:47.758Z",
        "updated_at": "2025-02-16T09:27:47.758Z"
    },
    "post": {
        "id": 205,
        "user_id": 129,
        "title": "New post title",
        "body": "Always two there are, no more, no less. A master and an apprentice.",
        "ip": "112.249.201.113",
        "created_at": "2025-02-16T10:49:55.804Z",
        "updated_at": "2025-02-16T10:49:55.804Z"
    }
}
```

Error response

```json
{
    "status": "bad_request",
    "error": "Invalid data of the form: Login can't be blank"
}
```

**Get posts**

You can get all or filtered posts. Look through examples

```bash
curl --location 'http://localhost:3000/posts' \
--header 'Accept: application/json'

curl --location 'http://localhost:3000/posts?limit=10&avarage_rating=2.33' \
--header 'Accept: application/json'
```
Response examples

```json
# all posts
[
    {
        "id": 200,
        "title": "Holy Stratosphere",
        "body": "Around the survivors a perimeter create."
    },
    {
        "id": 199,
        "title": "Holy Switch A Roo",
        "body": "To answer power with power, the Jedi way this is"
    },
    {
        "id": 198,
        "title": "Holy Standstills",
        "body": "Around the survivors a perimeter create."
    },
]

# filtered posts

[
    {
        "id": 200,
        "title": "Holy Cryptology",
        "body": "Ready are you? What know you of ready? For eight hundred years have I trained Jedi. My own counsel will I keep on who is to be trained. A Jedi must have the deepest commitment, the most serious mind. This one a long time have I watched. All his life has he looked away - to the future, to the horizon. Never his mind on where he was. Hmm? What he was doing. Hmph. Adventure. Heh. Excitement. Heh. A Jedi craves not these things. You are reckless.",
        "avarage_rating": "3.0"
    },
]
```


**Rate post**

Request example

```bash
curl --location 'http://localhost:3000/ratings' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--data '{
    "rating": {
        "user_id": 1,
        "post_id": 1,
        "value": 5
    }

}'
```
Response example

```json
{
    "status": "ok",
    "avarage_rating": 2.8,
    "post_id": 1
}
```

Error example:
```json
{
    "status": "bad_request",
    "error": "User has already rated this post"
}
```