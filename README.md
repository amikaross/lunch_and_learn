# Lunch and Learn API

This project was created for mod 3 of [Turing School of Software and Design](https://turing.edu/) 


## Table of Contents
- [About the Project](#about-the-project)
- [Database Schema](#database-schema)
- [Developer Setup](#developer-setup)
- [Endpoints](#endpoints)
- [Contact](#contact)

## About the Project
##### Learning Goals:
  - Expose an API that aggregates data from multiple external APIs
  - Expose an API that requires an authentication token
  - Expose an API for CRUD functionality
  - Determine completion criteria based on the needs of other developers
  - Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

##### Built With:
  - ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white) **2.7.4**
  - ![Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white) **5.2.8.1**

## Database Schema
<img src="doc/schema.png" alt="db schema" class="center" width="500" height="300">

## Developer Setup
If you would like to demo this API on your local machine:
  1. Ensure you have Ruby 2.7.4 and Rails 5.2.8 installed
  1. Fork and clone down this repo and navigate to the root folder
  1. Run `bundle install`
  1. Run `bundle exec figaro install`
  1. Register for an [edamam](https://developer.edamam.com/edamam-recipe-api) app id and key
  1. Register for an [unsplash]() key
  1. Register for a [google]() api key and enable the youtube api
  1. Add the following variables to `config/application.yml`:
      * `edamam_app_id`
      * `edamam_app_key`
      * `unsplash_key`
      * `google_api_key`
  1. Run `rails db:{drop,create,migrate,seed}`
  1. To run the test suite, run `bundle exec rspec` 
  1. To demo endpoints in postman or other tool, run `rails s` and use base url `http://localhost:3000` to explore the available endpoints

## Endpoints

<details close>
<summary> Get Recipes By Country</summary><br>

  - GET "/api/v1/recipes?country=country_name"
  - Sample response body: 
    ```
      {
        "data": [
            {
                "id": null,
                "type": "recipe",
                "attributes": {
                    "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                    "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                    "country": "thailand",
                    "image": "https://edamam-product-images.s3.amazonaws.com..."
                }
            },
            {
                "id": null,
                "type": "recipe",
                "attributes": {
                    "title": "THAI COCONUT CREMES",
                    "url": "https://food52.com/recipes/37220-thai-coconut-cremes",
                    "country": "thailand",
                    "image": "https://edamam-product-images.s3.amazonaws.com..."
                }
            },
            {...},
            {...},
          ...
        ]
      }
    ```
</details>

<details close>
<summary> Get Recipes for Random Country</summary><br>

  - GET "/api/v1/recipes"
  - Sample response body: 
    ```
      {
        "data": [
            {
                "id": null,
                "type": "recipe",
                "attributes": {
                    "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                    "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                    "country": "thailand",
                    "image": "https://edamam-product-images.s3.amazonaws.com..."
                }
            },
            {
                "id": null,
                "type": "recipe",
                "attributes": {
                    "title": "THAI COCONUT CREMES",
                    "url": "https://food52.com/recipes/37220-thai-coconut-cremes",
                    "country": "thailand",
                    "image": "https://edamam-product-images.s3.amazonaws.com..."
                }
            },
            {...},
            {...},
          ...
        ]
      }
    ```
</details>


<details close>
<summary> Get Learning Resources By Country</summary><br>

  - GET "/api/v1/learning_resources?country=country_name"<br>
  - Sample response body: <br>
    ```
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
                        "url": "https://images.unsplash.com/photo-1540611025311-01df3cef54b5..."
                    },
                    {
                        "alt_tag": "aerial view of city at daytime",
                        "url": "https://images.unsplash.com/photo-1570366583862-f91883984fde..."
                    },
                    {...},
                    {...},
                  ...
              ]
          }
      }
    ```
</details>

<details close>
<summary> Create A New User</summary><br>

  - POST "/api/v1/users"<br>
  - Sample request body: <br>
    ```
      {
        "name": "Athena Dao",
        "email": "athenadao@bestgirlever.com"
      }
    ```
  - Sample response body: <br>
    ```
      {
        "data": {
          "type": "user",
          "id": "1",
          "attributes": {
            "name": "Athena Dao",
            "email": "athenadao@bestgirlever.com",
            "api_key": "jgn983hy48thw9begh98h4539h4"
          }
        }
      }
    ```
</details>

<details close>
<summary> Create a New Favorite</summary><br>

  - POST "/api/v1/favorites"<br>
  - Sample request body: <br>
    ```
      {
          "api_key": "jgn983hy48thw9begh98h4539h4",
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/.....",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
      }
    ```
  - Sample response body: <br>
    ```
      {
        "success": "Favorite added successfully"
      }
    ```
</details>

<details close>
<summary> Get User's Favorites</summary><br>

  - GET "/api/v1/favorites/?api_key=user_api_key"<br>
  - Sample response body: <br>
    ```
      {
        "data": [
            {
                "id": "1",
                "type": "favorite",
                "attributes": {
                    "recipe_title": "Recipe: Egyptian Tomato Soup",
                    "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                    "country": "egypt",
                    "created_at": "2022-11-02T02:17:54.111Z"
                }
            },
            {
                "id": "2",
                "type": "favorite",
                "attributes": {
                    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
                    "recipe_link": "https://www.tastingtable.com/.....",
                    "country": "thailand",
                    "created_at": "2022-11-07T03:44:08.917Z"
                }
            }
          ]
       }    
    ```
  
</details>

## Contact

Built by Amanda Ross - find me on: [linkedin](https://www.linkedin.com/in/amanda-ross-2a62093a/) | [github](https://github.com/amikaross)


