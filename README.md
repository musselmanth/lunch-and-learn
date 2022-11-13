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

Base URL for requests: `http://localhost:3000/api/v1/`

### Get Recipes for a country

GET `/recipes`

**Optional Params:**

- country: Country name
  -if not provided a country will be chosen randomly

**Sample Response:**

```JSON
{
  "data": [
    {
      "id": null,
      "type": "recipe",
      "attributes": {
        "title": "Green Curry",
        "country": "thailand",
        "url": "https://url.to.recipe",
        "image": "https://url.to.recipe/image"
      }
    },
    **etc...**
  ]
}
```

### Get Learning Resource for a Country

GET `/learning_resources`

**Required Params:**

- country: Country Name

**Example Response:**

```JSON
{
  "data": {
    "id": null,
    "type": "learning_resource",
    "attributes": {
      "country": "laos",
      "video": {
        "title": "A Super Quick History of Laos",
        "youtube_video_id": "uw8hjVqxMXw"
      },
      "images": [
        {
          "alt_tag": "time lapse photography of flying hot air balloon",
          "url": "https://images.unsplash.com/photo-1540611025311-01df3cef54b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzODAyNDd8MHwxfHNlYXJjaHwxfHxsYW9zfGVufDB8fHx8MTY2ODMxMjI4MA&ixlib=rb-4.0.3&q=80&w=1080"
        },
        **etc...**
      ]
    }
  }
}
```
