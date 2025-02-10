---
tags:
  - Developer
---

title: How to update Content Objects | Flotiq docs
description: How to update Content Objects in Flotiq

# Updating content through the API

There are two ways to update the content of an object:

`PUT`:
When updating the object (`PUT` requests), all properties must be present in the request body,
as the object data are replaced with the request body.
Validation of update request works the same as in saving requests.

`PATCH`:
When updating an object (a `PATCH` request), it is not necessary to specify all the properties of the object.
Validating the update request works the same as it does when saving requests.

!!! note
    You will need to use your `Application Read and write API KEY` to perform this action
    or `User API KEY` scoped to accept update on the Content Type you wish to update.
    Read more about [API keys and scoped API keys](/docs/API/).

## Updating Content Objects through the API

For a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr>
defined according to the [create Content Type example](/docs/API/content-type/creating-ctd/), a very simple `PUT` payload can be sent
to the supporting endpoint `https://api.flotiq.com/api/v1/content/{name}/{id}` to update Content Object:

```
{
  "title": "Object with changed title",
  "postContent": "This will be the new <b>content</b>"
}
```
{ data-search-exclude }


* `name` is the name of the content type definition
* `id` is the ID of the object to update

!!! Example

    === "CURL"

        ```
        curl --location --request PUT 'https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712' \
        --header 'X-AUTH-TOKEN: YOUR_API_KEY' \
        --header 'Content-Type: application/json' \
        --header 'Accept: */*' \
        --data-raw '{
            "title": "Object with changed title",
            "postContent": "This will be the new <b>content</b>"
        }'
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712");
        var request = new RestRequest(Method.PUT);
        request.AddHeader("content-type", "application/json");
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        request.AddParameter("application/json", "{\"title\":\"Object with changed title\",\"postContent\":\"This will be the new <b>content</b>\"}", ParameterType.RequestBody);
        IRestResponse response = client.Execute(request);
        ```
        { data-search-exclude }
    
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
        
            url := "https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712"
        
            payload := strings.NewReader("{\"title\":\"Object with changed title\",\"postContent\":\"This will be the new <b>content</b>\"}")
        
            req, _ := http.NewRequest("PUT", url, payload)
        
            req.Header.Add("content-type", "application/json")
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

        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, "{\"title\":\"Object with changed title\",\"postContent\":\"This will be the new <b>content</b>\"}");
        Request request = new Request.Builder()
        .url("https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712")
        .put(body)
        .addHeader("content-type", "application/json")
        .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
        .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.put("https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712")
            .header("content-type", "application/json")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .body("{\"title\":\"Object with changed title\",\"postContent\":\"This will be the new <b>content</b>\"}")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'PUT',
            url: 'https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712',
            headers: {'content-type': 'application/json', 'X-AUTH-TOKEN': 'YOUR_API_KEY'},
            body: {title: 'Object with changed title', postContent: 'This will be the new <b>content</b>'},
            json: true
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
        CURLOPT_CUSTOMREQUEST => "PUT",
        CURLOPT_POSTFIELDS => "{\"title\":\"Object with changed title\",\"postContent\":\"This will be the new <b>content</b>\"}",
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
        { data-search-exclude }


!!! Response

    === "200 OK"

        Returned when data has been correct, and the object was saved

        ```
        {
            "id": "blogposts-456712",
            "internal": {
                "contentType": "blogposts",
                "createdAt": "2021-04-09T13:30:48+00:00",
                "updatedAt": "2021-04-09T13:30:48+00:00",
                "deletedAt": ""
            },
            "title": "Object with changed title",
            "postContent": "This will be the new <b>content</b>"
        }
        ```
        { data-search-exclude }

    === "400 Validation error"

        Returned when data has not been correct, and the object was not saved

        ```
        {
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

        Returned when the content object wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```
        { data-search-exclude }
        
    === "413 Request Entity Too Large"

        Returned when the size of the object exceeds the limit allowed in Flotiq (1MB, except << plan_names.paid_3 >> plan)

        ```
        {
            "code": 413,
            "massage": "Content Object size limit exceeded by an object with ID: 185. Requested size 1.01 MB, limit: 1 MB)"
        }
        ```
        { data-search-exclude }

!!! note
    The id property of the object can be updated through API if id provided in the request body is different from the one provided in request path.
    This only works in updating single content object

#### Possible validation errors

Possible validation errors are the same as in creating Content Object,
you can find the list [here](/docs/API/content-type/creating-co/#possible-validation-errors).

## Batch update Content Objects through API

Updating up to 100 objects with single POST request at once is described
[here](/docs/API/content-type/creating-co/#batch-create-content-objects-through-api),
as batch creating and updating are done on the same API endpoint.

It is also possible to update objects using the PATCH method.
In the case of PATH, it is not required to provide all object fields, only those that are to be changed.
When an object doesn't exist, the batch patch returns a 404 error response. The PATCH endpoint doesn't create new objects.

[Register to start creating your content objects](https://editor.flotiq.com/register.html){: .flotiq-button}
