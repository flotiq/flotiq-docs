title: How to add Content Objects | Flotiq docs
description: How to add Content Objects in Flotiq

# Content Objects

Once a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> 
has been defined in the system - the user can create 
<abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr>  of that Content Type. 
This is done either directly through the API or via the convenient Content Entry tools provided within the 
Content Management Platform.

!!! note
    You will need to use your `Application Read and write API KEY` to perform this action 
    or `User API KEY` scoped to accept create on the Content Type you wish to add. 
    Read more about [API keys and scoped API keys](/API/).

## Creating Content Objects through the API

For a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> 
defined according to the [create Content Type example](/API/content-type/creating-ctd), a very simple `POST` payload can be sent 
to the supporting endpoint `https://api.flotiq.com/api/v1/content/{name}` 
(where `name` is the name of the content type definition) to create a new Content Object:

```
{
  "title": "New object",
  "postContent": "This will be the new <b>content</b>"
}
```

!!! note
    You can send custom `id` in the object data to assign particular `id` to the object. 
    Random `id` will be assigned when `id` property is not present in the object.

!!! Example

    === "CURL"

        ```shell
        curl --location --request POST 'https://api.flotiq.com/api/v1/content/blogposts' \
        --header 'X-AUTH-TOKEN: YOUR_API_KEY' \
        --header 'Content-Type: application/json' \
        --header 'Accept: */*' \
        --data-raw '{
          "title": "New object",
          "postContent": "This will be the new <b>content</b>"
        }'
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts");
        var request = new RestRequest(Method.POST);
        request.AddHeader("content-type", "application/json");
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        request.AddParameter("application/json", "{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}", ParameterType.RequestBody);
        IRestResponse response = client.Execute(request);
        ```
    
    === "Go + Native"

        ```
        package main

        import (
            "fmt"
            "strings"
            "net/http"
            "io/ioutil"
        )
        
        func main() {
        
            url := "https://api.flotiq.com/api/v1/content/blogposts"
        
            payload := strings.NewReader("{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}")
        
            req, _ := http.NewRequest("POST", url, payload)
        
            req.Header.Add("content-type", "application/json")
            req.Header.Add("X-AUTH-TOKEN", "YOUR_API_KEY")
        
            res, _ := http.DefaultClient.Do(req)
        
            defer res.Body.Close()
            body, _ := ioutil.ReadAll(res.Body)
        
            fmt.Println(res)
            fmt.Println(string(body))
            
        }
        ```
    
    === "Java + Okhttp"
        
        ```
        OkHttpClient client = new OkHttpClient();

        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, "{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}");
        Request request = new Request.Builder()
        .url("https://api.flotiq.com/api/v1/content/blogposts")
        .post(body)
        .addHeader("content-type", "application/json")
        .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
        .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.post("https://api.flotiq.com/api/v1/content/blogposts")
            .header("content-type", "application/json")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .body("{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}")
            .asString();
        ```

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'POST',
            url: 'https://api.flotiq.com/api/v1/content/blogposts',
            headers: {'content-type': 'application/json', 'X-AUTH-TOKEN': 'YOUR_API_KEY'},
            body: {title: 'New object', postContent: 'This will be the new <b>content</b>'},
            json: true
        };
        
        request(options, function (error, response, body) {
        if (error) throw new Error(error);
        
        console.log(body);
        });
        ```

    === "PHP + CURL"
    
        ```
        <?php

        $curl = curl_init();
        
        curl_setopt_array($curl, [
        CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "POST",
        CURLOPT_POSTFIELDS => "{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}",
        CURLOPT_HTTPHEADER => [
                "X-AUTH-TOKEN: YOUR_API_KEY",
                "content-type: application/json"
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


!!! Responses

    === "200 OK"

        Returned when data has been correct and object was saved

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
        ```

    === "400 Validation error"

        Returned when data has not been correct and object was not saved

        ```
        {
            "id": [
                "This value is already used",
                "Must be at least 1 characters long",
            ],
            "title": [
                "The property title is required",
                "Must be at least 1 characters long",
                "The property title is required"
            ],
            "postContent": [
                "The property postContent is required",
                "Must be at least 1 characters long",
                "The property postContent is required"
            ]
        }
        ```

    === "401 Unauthorized"

        Returned when API key was missing or incorrect
  
        ```
        {
            "code": 401,
            "massage": "Unauthorized"
        }
        ```

    === "404 Not found"

        Returned when content object wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```

#### Possible validation errors

| Error                                        | Description                                                                                        |
| -------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| This value is already used                   | Send when property have to be unique and the value is already used in existing object of that type |
| Must be at least 1 characters long           | Send when property is required and empty string was sent in object                                 |
| The property {name} is required              | Send when property is required and was missing in the sent object                                  |
| String value found, but a number is required | Send when type of the property is `number` and string was sent                                     |
| The value does not match possible options    | Send when sent value do not match options in `select` and `radio` type                             |
| Does not match the regex pattern {pattern}   | Send when value do not match regex pattern specified for the property                              |
| This value does not exist in database        | Send when object attached in relation or media array not exists in the database                    |


### Creating Content Objects with relations to other types or media

To add objects with relations you need to know ids and types of relation objects. 
Relations are always an array, event if only one relation object is allowed.
Order of relation object is preserved. 
Every relation object have to have `type` property (now only `internal` is possible), 
and `dataUrl` property containing relative url to the object (`/api/v1/content/{type}/{id}`).

!!! Example
    
    === "Relation to `test` content type object"
        
        ```
        "relation": [
            {
              "dataUrl": "/api/v1/content/test/test-1",
              "type": "internal"
            }
        ]
        ```

    === "Multiple relation to media objects"
        
        ```
        "media": [
            {
              "dataUrl": "/api/v1/content/_media/_media-1",
              "type": "internal"
            },
            {
              "dataUrl": "/api/v1/content/_media/_media-2",
              "type": "internal"
            }
        ]
        ```        


??? "Example of object containing all property types"

    This exmple represents object for Content Type with every type of property, described [here](/API/content-type/creating-ctd/#example-with-every-type-of-field)

    ```
    {
      "id": "example-1",
      "geo": {
        "lat": 0,
        "lon": 0
      },
      "list": [
        {
          "text_in_subobject": "text",
          "emain_in_subobject": "emain_in_subobject",
          "media_in_subobject": [
            {
              "dataUrl": "/api/v1/content/_media/_media-1",
              "type": "internal"
            }
          ],
          "radio_in_subobject": "radio_in_subobject",
          "number_in_subobject": 0,
          "select_in_subobject": "Option a",
          "checkbox_in_subobject": false,
          "markdown_in_subobject": "markdown_in_subobject",
          "relation_in_subobject": [
            {
              "dataUrl": "/api/v1/content/test/test-1",
              "type": "internal"
            }
          ],
          "textarea_in_subobject": "textarea_in_subobject",
          "rich_text_in_subobject": "rich_text_in_subobject"
        }
      ],
      "text": "02-02-2021",
      "email": "email",
      "media": [
        {
          "dataUrl": "/api/v1/content/_media/_media-1",
          "type": "internal"
        }
      ],
      "radio": "Option 1",
      "number": 0,
      "select": "Option 1",
      "checkbox": false,
      "markdown": "markdown",
      "relation": [
        {
          "dataUrl": "/api/v1/content/test/test-1",
          "type": "internal"
        }
      ],
      "textarea": "textarea",
      "rich_text": "rich_text"
    }
    ```


## Batch create Content Objects through API

There is a way to add up to 100 of Content Objects at once. 
It is possible by using `/batch` endpoint 
(in our example the URL would be `https://api.flotiq.com/api/v1/content/blogposts/batch`). 
It can be only `insert` or `insert or update` operation. To use `insert or update` 
you need to set `updateExisting` to `true` in the query. 

All objects must meet the same conditions as when adding a single object. 
The only difference is an array of objects in the request body instead of one object.

Updating one blog post and adding one new:

!!! Example
    
    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object","postContent":"This will be the new <b>content</b>"},{"title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 200):
    ```
    {
        "batch_total_count": 2,
        "batch_success_count": 2,
        "batch_error_count": 0,
        "errors": []
    }
    ```
    
Trying updating one blog post and adding one new with wrong data:
    
!!! Example
    
    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object"},{"title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 400):
    ```
    {
        "batch_total_count": 2,
        "batch_success_count": 1,
        "batch_error_count": 1,
        "errors": [
          {
            "id": "123123123",
            "errors": {
              "postContent": [
                "The property postContent is required"
              ]
            }
          }
        ]
    }
    ```

Trying updating one blog post and adding one new with duplicated id:
    
!!! Example
    
    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object","content": "This will be the new <b>content</b>"},{"id":"123123123","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 400):
    ```
    {
      "data": [
        "There are duplications in object data, key: id"
      ]
    }
    ```

Response parameters:

| Parameter           | Description                                                                                                                                            |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| batch_total_count   | number of elements sent in the request, present when there are no duplications in data                                                                 |
| batch_success_count | number of correct elements sent in the request, present when there are no duplications in data                                                         |
| batch_error_count   | number of incorrect elements sent in the request, present when there are no duplications in data                                                       |
| errors              | array of errors in the elements, errors are objects containing the id of the object and list of errors, present when there are no duplications in data |
| data                | present only when there are duplications in data, listing keys containing duplications (see example above)                                             |

[Register to start creating your content objects](https://editor.flotiq.com/register.html){: .flotiq-button}
