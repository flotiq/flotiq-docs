title: How to list deleted Content Objects | Flotiq docs
description: How to list deleted Content Objects in Flotiq

<div class="breadcrumbs">
<a href="/">Docs</a> / <a href="/API/">API</a> / <a href="/API/content-objects/">Content objects</a> / <a href="/API/content-type/listing-deleted-co/">Listing deleted Content Objects</a>
</div>

# Listing ids of deleted Content Objects

Once a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr>
has been defined in the system - the user can list ids of removed objects
<abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr> of that Content Type.

!!! note
    You have to use your `Application Read and write API KEY` to perform this action
    or `User API KEY` scoped to accept read and delete on the Content Type you wish to list.
    Read more about [API keys and scoped API keys](/docs/API/).

## Listing ids of deleted Content Objects through API

To list ids of the deleted Content Objects, you use the `/api/v1/content/{name}/removed` endpoint
(where `name` is the name of the content type definition).
It lists all of the deleted Content Objects of the Content Type.
You can filter Content Objects using the `deletedAfter` query parameter
containing the date after which the Content Objects were deleted; the date must be in the format accepted by the [DateTime::format](https://www.php.net/manual/en/datetime.format.php) function.


!!! Example

    === "CURL"

        ```
        curl --location --request GET "https://api.flotiq.com/api/v1/content/blogposts/removed?deletedAfter=2020-06-17%2009:00:00" \
        --header "accept: application/json" \
        --header "X-AUTH-TOKEN: YOUR_API_TOKEN"
        ``` 

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts/removed");
        var request = new RestRequest(Method.GET);
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        IRestResponse response = client.Execute(request);
        ```
    
    === "Go + Native"

        ```
        package main

        import (
            "fmt"
            "net/http"
            "io/ioutil"
        )
        
        func main() {
        
            url := "https://api.flotiq.com/api/v1/content/blogposts/removed"
        
            req, _ := http.NewRequest("GET", url, nil)
        
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

        Request request = new Request.Builder()
        .url("https://api.flotiq.com/api/v1/content/blogposts/removed")
        .get()
        .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
        .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/blogposts/removed")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'GET',
            url: 'https://api.flotiq.com/api/v1/content/blogposts/removed',
            headers: {'X-AUTH-TOKEN': 'YOUR_API_KEY'}
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
        CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts/removed",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "GET",
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

!!! Response

    === "200 OK"

        Returned when content type exists and deletedAfter was correct or not sent

        ```
        ["blogposts-1","blogposts-2"]
        ```

    === "400 Validation error"

        Returned when deletedAfter was incorrect

        ```
        {
            "deletedAfter": [
                "Wrong date format"
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

#### Possible validation errors

| Error              | Description                                                                     |
| ------------------ | ------------------------------------------------------------------------------- |
| Wrong date format. | Send when Flotiq could not parse the date in the `deletedAfter` query parameter |

## Listing ids of deleted Content Objects through Content modeller

It is impossible for now to list deleted Content Objects through Flotiq UI.

[Register to start creating your content objects](https://editor.flotiq.com/register.html){: .flotiq-button}
