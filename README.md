# Lunch and Learn

## About

## Learning Goals

## Local Setup

```
# clone the repository
git clone git@github.com:musselmanth/lunch-and-learn.git

cd lunch-and-learn
bundle install

# setup the database
rails db:{create,migrate}

# run the local server
rails server
```

## Database Schema Diagram

## Available Endpoints

Base URL for requests: `http://localhost:3000/api/v1`

### Get Recipes for a country

**Optional Params:**

- country: Country name
  -if not provided a country will be chosen randomly

**Sample Response:**

```JSON
{
  data: [
    {
      "id": null,
      "type": "recipe",
      "attributes": {
        title: "Green Curry",
        country: "thailand",
        url: "https://url.to.recipe",
        image: "https://url.to.recipe/image"
      }
    },
    **etc...**
  ]
}
```
