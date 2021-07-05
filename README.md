# Comics App

Using the [Marvel API](https://developer.marvel.com/) displays all comics released by Marvel and also allows the user to mark specific comics as favorite.

## Running the development environment

### Using Docker

Create the env file with `cp env .env`, and replace the public and private keys values

Run: `docker-compose up --build`

### Without Docker

You need to have the version 2.7.3 of ruby, bundler, node 14.x and yarn installed

Run the following steps:

```shell
bundle install
yarn install
bundle exec rails server
```

The application will be running at: http://localhost:3000

## Dependencies

- The gem Faraday was used on the backend to communicate with the Marvel API
- React was the frontend framework chosen to implement the interfaces

## Future Work

- Backend to upvote comics
- Frontend to paginate the comics list
- Implement frontend tests using Jest
- Increase tests coverage of the backend
