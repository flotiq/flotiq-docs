title: How to delete Content Type Definitions | Flotiq docs
description: How to delete Content Type Definitions in Flotiq API

# Deleting Content Types

Existing <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content
Type</abbr>
can be deleted either by sending a properly formatted `DELETE` request to the ``/api/v1/internal/contenttype/{name}``
endpoint or through the Content Modeler tool provided with the platform.

!!! note
    You will need to use your `Application Read and write API KEY` to perform this action. Read more about [API keys and scoped API keys](/API/).


## Deleting Content Types via API

Deleting <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">
Content Type</abbr> is simply a ``DELETE`` call without a payload.

You can only delete Content Types that do not have any Content Objects or are not assigned to the scoped API key.


!!! Example

    === "CURL"
    
        ```
        curl -X DELETE "https://api.flotiq.com/api/v1/internal/contenttype/blogposts" -H 'accept: */*' -H 'X-AUTH-TOKEN: YOUR_API_KEY'
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/internal/contenttype/blogposts");
        var request = new RestRequest(Method.DELETE);
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
        
            url := "https://api.flotiq.com/api/v1/internal/contenttype/blogposts"
        
            req, _ := http.NewRequest("DELETE", url, nil)

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
            .url("https://api.flotiq.com/api/v1/internal/contenttype/blogposts")
            .delete(null)
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.delete("https://api.flotiq.com/api/v1/internal/contenttype/blogposts")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'DELETE',
            url: 'https://api.flotiq.com/api/v1/internal/contenttype/blogposts',
            headers: {'X-AUTH-TOKEN': 'YOUR_API_KEY'},
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/internal/contenttype/blogposts",
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

!!! Responses

    === "200 OK"

        Returned when the schema has been removed


    === "400 Validation error"

        Returned when the schema has not been removed

        ```
        {
            "errors": [
                "This content type definition is used by Api Key: New key",
                "Content Type has objects, you can't remove it!"
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

        Returned when the schema wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```


## Deleting Content Types through the Content modeller

If you'd rather use our graphical interface to delete your Content Types - read the [Content modeller documentation](/panel/content-types/)

[Register to send all requests with your own API today](https://editor.flotiq.com/register.html){: .flotiq-button}
