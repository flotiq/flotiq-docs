---
tags:
  - Developer
---

title: How to delete Content Objects | Flotiq docs
description: How to delete Content Objects in Flotiq

# Deleting content objects

!!! note
    You will need to use your `Application Read and write API KEY` to perform this action
    or `User API KEY` scoped to accept delete on the Content Type you wish to delete.
    Read more about [API keys and scoped API keys](/docs/API/).

## Deleting a single object

Deleting is done by sending `DELETE` request to `https://api.flotiq.com/api/v1/content/{name}/{id}`, where:

* `name` is the name of the content type definition
* `id` is the ID of the object to remove


!!! Example

    === "CURL" 

        ```
        curl --location --request DELETE "https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712" \
        --header "accept: application/json" \
        --header "X-AUTH-TOKEN: YOUR_API_TOKEN"
        ``` 
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712");
        var request = new RestRequest(Method.DELETE);
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
        
            url := "https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712"
        
            req, _ := http.NewRequest("DELETE", url, nil)
        
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
        .url("https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712")
        .delete(null)
        .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
        .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.delete("https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712")
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
            headers: {'X-AUTH-TOKEN': 'YOUR_API_KEY'}
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

    === "204 OK"

        Returned when the object was deleted

    === "400 Validation error"

        Returned when data has not been correct, and the object was not deleted

        ```
        {
            "errors": [
                "This content object is used in another content object."
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

#### Possible validation errors

| Error                                                  | Description                                                |
| ------------------------------------------------------ | ---------------------------------------------------------- |
| This content object is used in another content object. | Send when the object is used in relation of another object |

## Batch deleting

Batch deleting can remove up to 100[^1] objects at a time.
If you need to batch delete items, you need to send `POST` request to `https://api.flotiq.com/api/v1/content/{CTD name}/batch-delete`, where:

* `CTD name` is the name of the content type definition

Body of the request must contain the array of object ids to remove, for example: `['blogposts-1', 'blogposts-2']`.

If the system deleted all objects, the endpoint would return `200 OK` response with:
```
{
    "deletedCount": numOfDeletedObjects
}
```
{ data-search-exclude }

where:

* `numOfDeletedObjects` is number of deleted objects as integer

For example:
```
{
    "deletedCount": 2
}
```
{ data-search-exclude }

If any of the objects could not be removed (as being used in the relation or as not existing), the system will remove all items that exist and are not in the relation within another object; for the rest of objects, the endpoint will return `400 Validation error` response with:
```
{   
    "errors": [
        listOfErrors
    ]
}
```
{ data-search-exclude }

where:

* `listOfErrors` is the list of errors; each line have information about the id

For example:
```
{
    "errors": [
        "Content object: \"blogposts-1\" doesn't exist",
        "Content object: \"blogposts-2\" is used in another content object."
    ]
}
```
{ data-search-exclude }

Request example:

```
curl -X POST "https://api.flotiq.com/api/v1/content/blogposts/batch-delete" -H "accept: schema" -H "X-AUTH-TOKEN: YOUR_API_TOKEN" -H "Content-Type: application/json" -d "[\"blogposts-1\",\"blogposts-2\"]"
```
{ data-search-exclude }

[Register to start creating your content objects](https://editor.flotiq.com/register?plan=1ef44daa-fdc3-6790-960e-cb20a0848bfa){: .flotiq-button}

[^1]: Limit can be changed in the [<< plan_names.paid_3 >> plan](https://flotiq.com/pricing){:target="_blank"}
