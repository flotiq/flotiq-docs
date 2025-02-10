---
tags:
  - Developer
---

Title: Get Started with Flotiq API Integration

Description: Get started with integrating Flotiq API into your application.

!!! note "Before you begin, make sure you have the following:"
    * Flotiq Account: Sign up for an account on [Flotiq website](https://www.flotiq.com/){target="_blank"} if you haven't already.
    * Content Types: Make sure you have already created the necessary [Content Type Definitions](https://editor.flotiq.com/content-type-definitions){target="_blank"} in your Flotiq account. It should contain at least one Content Object.
    * API Key: Obtain your Application Read and Write API Key from the [Flotiq dashboard](https://editor.flotiq.com/api-keys){target="_blank"}. You'll need it to perform API operations.
    * Basic understanding of RESTful APIs: Familiarize yourself with the concepts of [RESTful APIs](https://restfulapi.net/){target="_blank"} if you're new to this.
    

#### Step 1: Implementing API Integration
Once you have your Content Type Definitions ready, you can proceed with integrating Flotiq API into your application. Here's a high-level overview of the steps involved:

* Authentication: Use your [API key](index.md) to authenticate API requests. Include the key in the request headers or as a query parameter, depending on the API endpoint.
* Data Manipulation: Perform CRUD operations ([Create](content-type/creating-ctd.md), [Read](content-type/getting-ctd.md), [Update](content-type/updating-ctd.md), [Delete](content-type/deleting-ctd.md)) on your Content Types using the appropriate API endpoints and HTTP methods.
* Handling Responses: Handle the API responses in your application code to process the data returned by the API and handle errors gracefully.
* Testing and Debugging: Use tools like CURL or Postman to test your API requests and ensure they are working as expected.
* Best Practices: Follow best practices for API integration, such as using pagination for large result sets, implementing caching mechanisms, and handling rate limits.

Flotiq provides two options for retrieving data: REST API and GraphQL. Here's an overview of the steps involved:

##### For REST API:
Retrieve the schema of a specific Content Object by sending a `GET` request to the `https://api.flotiq.com/api/v1/content/{name}/{id}` endpoint. [Check the documentation](content-type/getting-co.md) for more details.

!!! Example

    === "CURL"

        ``` 
        curl --location --request GET "https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712" \
        --header "accept: application/json" \
        --header "X-AUTH-TOKEN: YOUR_API_TOKEN"
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogpostsblogposts-456712");
        var request = new RestRequest(Method.GET);
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        IRestResponse response = client.Execute(request);
        ```
        { data-search-exclude }

    === "Go + Native"

        ```
        package main

        import (
            "fmt"
            "net/http"
            "io/ioutil"
        )
        
        func main() {
        
            url := "https://api.flotiq.com/api/v1/content/blogpostsblogposts-456712"
        
            req, _ := http.NewRequest("GET", url, nil)

            req.Header.Add("X-AUTH-TOKEN", "YOUR_API_KEY")
        
            res, _ := http.DefaultClient.Do(req)
        
            defer res.Body.Close()
            body, _ := ioutil.ReadAll(res.Body)
        
            fmt.Println(res)
            fmt.Println(string(body))
        
        }
        ```
        { data-search-exclude }

    === "Java + Okhttp"
        
        ```
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
            .url("https://api.flotiq.com/api/v1/content/blogpostsblogposts-456712")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/blogpostsblogposts-456712")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'DELETE',
            url: 'https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712',
            headers: {'X-AUTH-TOKEN': 'YOUR_API_KEY'},
        };
        
        request(options, function (error, response, body) {
            if (error) throw new Error(error);
            
            console.log(body);
        });
        ```
        { data-search-exclude }

    === "PHP + CURL"
    
        ```
        <?php

        $curl = curl_init();
        
        curl_setopt_array($curl, [
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "DELETE",
            CURLOPT_HTTPHEADER => [
                    "X-AUTH-TOKEN: YOUR_API_KEY",
                ],
        ]);
        
        $response = curl_exec($curl);
        $err = curl_error($curl);
        
        curl_close($curl);
        
        if ($err) {
            echo "cURL Error #:" . $err;
        } else {
            echo $response;
        }
        ```
        { data-search-exclude }

!!! Response

    === "200 OK"

        Returned when the object was found

        ```
        {
          "id": "blogposts-456712",
            "internal": {
                "contentType": "blogposts",
                "createdAt": "2021-04-09T13:30:48+00:00",
                "updatedAt": "2021-04-09T13:30:48+00:00",
                "deletedAt": ""
            },
            "title": "New object",
            "postContent": "This will be the new <b>content</b>"
          }
        }
        ```
        { data-search-exclude }

    === "401 Unauthorized"

        Returned when API key was missing or incorrect
  
        ```
        {
            "code": 401,
            "massage": "Unauthorized"
        }
        ```
        { data-search-exclude }

    === "404 Not found"

        Returned when content type definition wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```
        { data-search-exclude }


##### For GraphQL:

Flotiq supports [GraphQL queries](graph-ql.md) for Content Objects. You can use the following endpoints to interact with the system using GraphQL:

* `GET /api/graphql/schema` - Retrieve the GraphQL schema that describes your data.
* `POST /api/graphql` - Execute GraphQL queries to retrieve specific data.

To a get single object, you need to pass the object identifier and fields you want to receive in the response. 
Example Query in GraphQL language to get `id` and `title` for the product with id `blogposts-456712` looks like:

!!! GraphQL query

    ```graphql
    query {
        blogposts(id:"blogposts-456712") {
            id
            title
        }
    }
    ```
    { data-search-exclude }

To pass this query to the Flotiq, you need to call:

!!! Example

    === "CURL"

        ``` 
        curl -X POST 'https://api.flotiq.com/api/graphql' \
        --header 'X-AUTH-TOKEN: YOUR_API_TOKEN' \
        --header 'Content-Type: application/json' \
        --data-raw '{"query":"query { blogposts(id: \"blogposts-456712\") { id title } }"}'
        ```
        { data-search-exclude }

    === "JavaScript + Fetch"

        ```
        fetch('https://api.flotiq.com/api/graphql', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-AUTH-TOKEN': 'YOUR_API_TOKEN'
            },
            body: JSON.stringify({
                query: 'query { blogposts(id: "blogposts-456712") { id title } }'
            })
        })
        .then(response => response.json())
        .then(data => console.log(data));
        ```
        { data-search-exclude }

    === "Node + Axios"

        ```
        const axios = require('axios');

        axios.post('https://api.flotiq.com/api/graphql', {
            query: 'query { blogposts(id: "blogposts-456712") { id title } }'
        }, {
            headers: {
                'Content-Type': 'application/json',
                'X-AUTH-TOKEN': 'YOUR_API_TOKEN'
            }
        })
        .then(response => console.log(response.data))
        .catch(error => console.log(error));
        ```
        { data-search-exclude }

    === "Python + Requests"

        ```
        import requests

        url = 'https://api.flotiq.com/api/graphql'
        headers = {
            'Content-Type': 'application/json',
            'X-AUTH-TOKEN': 'YOUR_API_TOKEN'
        }
        data = {
            'query': 'query { blogposts(id: "blogposts-456712") { id title } }'
        }

        response = requests.post(url, headers=headers, json=data)
        print(response.json())
        ```
        { data-search-exclude }


!!! Response
    === "200 OK"

        Returned when the object was found

        ```json
        {
            "data": {
                "blogposts": {
                    "id": "blogposts-456712",
                    "title": "New object"
                }
            }
        }
        ```
        { data-search-exclude }

    === "401 Unauthorized"

        Returned when the API key was missing or incorrect

        ```json
        {
            "errors": [
                {
                    "message": "Unauthorized",
                    "extensions": {
                        "code": "UNAUTHORIZED"
                    }
                }
            ]
        }
        ```
        { data-search-exclude }

    === "404 Not found"

        Returned when the content type definition wasn't found

        ```json
        {
            "errors": [
                {
                    "message": "Not found",
                    "extensions": {
                        "code": "NOT_FOUND"
                    }
                }
            ]
        }
        ```
        { data-search-exclude }

#### Step 2: Exploring Advanced Features
Flotiq API offers various advanced features and functionalities to enhance your application. Here are a few examples:

* Search: Perform advanced [search queries](search.md) to retrieve specific data from your Content Types.
* Media Management: Upload and [manage media](media-library.md) assets such as images and videos in your application.

Congratulations! You now have a basic understanding of integrating Flotiq API into your application. Start by creating your Content Type Definitions and then follow the API integration steps to build powerful applications using Flotiq. If you need further assistance, refer to the specific sections in the documentation or reach out to our support team.
