# Blog

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Seed database with `mix run priv/repo/seeds.exs`
  * Start Phoenix endpoint with `mix phx.server`

To test:

  * Navigate to `http://localhost:4000/graphiql`
  * Try a few queries & mutations, eg:

  #### query (unauthorized)
  ``` 
  {
    user(id: 1) {
      id
      username
      email
    }
  }
  ```
  #### response

  ```
  {
    "data": {
      "user": {
        "username": "User A",
        "id": null,
        "email": null
      }
    }
  }
  ```

  #### query (w/ header: authorization: "useratoken")
  ```
  {
    user(id: 1) {
      id
      username
      email
    }
  }
  ```

  #### response
  ```
  {
    "data": {
      "user": {
        "username": "User A",
        "id": "5",
        "email": "secretemail1@email.com"
      }
    }
  }
  ```

  #### mutation
  ```
  mutation CreatePost {
    createPost(title: "Post Title", body:"Body of the post.") {
      body
      title
    }
  }
  ```

  #### response 
  ```
  {
    "errors": [
      {
        "path": [
          "createPost"
        ],
        "message": "In field \"createPost\": Unauthorized",
        "locations": [
          {
            "line": 3,
            "column": 0
          }
        ]
      }
    ],
    "data": {
      "createPost": null
    }
  }
  ```

  #### mutation (w/ header: authorization: "userbtoken")
  ```
  mutation CreatePost {
    createPost(title: "Post Title", body:"Body of the post.") {
      body
      title
    }
  }
  ```

  #### response
  ```
  {
    "data": {
      "createPost": {
        "title": "Post Title",
        "body": "Body of the post."
      }
    }
  }
  ```