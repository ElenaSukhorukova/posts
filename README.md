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

You can get all or filtered posts. Look through examples.

```bash
curl --location 'http://localhost:3000/posts' \
--header 'Accept: application/json'

curl --location 'http://localhost:3000/posts?limit=3&avarage_rating=2.8' \
--header 'Accept: application/json'

curl --location 'http://localhost:3000/posts?ips=204.129.100.85,226.249.183.227,227.67.53.110' \
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

# filtered by limit and avarage_ratings
[
    {
        "id": 196,
        "title": "Holy Perfect Pitch",
        "body": "Difficult to see. Always in motion is the future...",
        "avarage_ratings": "2.8"
    },
    {
        "id": 175,
        "title": "Holy Hamstrings",
        "body": "Much to learn you still have my old padawan. ... This is just the beginning!",
        "avarage_ratings": "2.8"
    },
    {
        "id": 2,
        "title": "Holy Long John Silver",
        "body": "Once you start down the dark path, forever will it dominate your destiny, consume you it will.",
        "avarage_ratings": "2.8"
    }
]

# filtered by ips

[
    {
        "227.67.53.110": [
            "Keiko",
            "Jeffrey",
            "Fidel",
            "Jetta",
            "Roderick"
        ]
    },
    {
        "204.129.100.85": [
            "Myrtie",
            "Cedric",
            "Alvin",
            "Anisa"
        ]
    },
    {
        "226.249.183.227": [
            "Silas",
            "Haley",
            "Jerrie",
            "Vito",
            "Waldo"
        ]
    }
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
