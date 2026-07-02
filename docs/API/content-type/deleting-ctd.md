---
tags:
  - Developer
---

title: How to delete Content Type Definitions | Flotiq docs
description: How to delete Content Type Definitions in Flotiq API

# Deleting Content Types

Existing <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content
Type</abbr>
can be deleted either by sending a properly formatted `DELETE` request to the ``/api/v1/internal/contenttype/{name}``
endpoint or through the Content Modeler tool provided with the platform.

!!! note
    You will need to use your `Application Read and write API KEY` to perform this action. Read more about [API keys and scoped API keys](/docs/API/).


## Deleting Content Types via API

Deleting <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">
Content Type</abbr> is simply a ``DELETE`` call without a payload.

You can only delete Content Types that do not have any Content Objects or are not assigned to the scoped API key.


!!! Example

    === "CURL"

        ```
        curl --location --request DELETE "https://api.flotiq.com/api/v1/internal/contenttype/blogposts" \
        --header 'accept: */*' \
        --header 'X-AUTH-TOKEN: YOUR_API_KEY'
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/internal/contenttype/blogposts");
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
        { data-search-exclude }

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
        { data-search-exclude }

    === "Java + Unirest"

        ```
        HttpResponse<String> response = Unirest.delete("https://api.flotiq.com/api/v1/internal/contenttype/blogposts")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```
        { data-search-exclude }

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
        { data-search-exclude }

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
        { data-search-exclude }

!!! Response

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
        { data-search-exclude }

    === "401 Unauthorized"

        Returned when API key was missing or incorrect

        ```
        {
            "code": 401,
            "message": "Unauthorized"
        }
        ```
        { data-search-exclude }

    === "404 Not found"

        Returned when the schema wasn't found

        ```
        {
            "code": 404,
            "message": "Not found"
        }
        ```
        { data-search-exclude }

## Deleting Content Types via Purge endpoint

If you need to delete a content type together with its content objects, you can use the purge endpoint with
the deleteSchema option set to "true". If deleteSchema is set to false, only the objects for the given content type
will be removed. The deleteSchema option is optional and defaults to false.

!!! Example

    === "CURL"

        ```
        curl --location --request POST "https://api.flotiq.com/api/v1/internal/contenttype/blogposts/purge" \
        --header 'accept: */*' \
        --header 'Content-Type: application/json' \
        --header 'X-AUTH-TOKEN: YOUR_API_KEY' \
        --data-raw '{"deleteSchema": true}'
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/internal/contenttype/blogposts/purge");
        var request = new RestRequest(Method.POST);
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        request.AddParameter("application/json", "{\"deleteSchema\": true}", ParameterType.RequestBody);
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
            "strings"
        )

        func main() {

            url := "https://api.flotiq.com/api/v1/internal/contenttype/blogposts/purge"

            payload := strings.NewReader(`{"deleteSchema": true}`)

            req, _ := http.NewRequest("POST", url, payload)

            req.Header.Add("X-AUTH-TOKEN", "YOUR_API_KEY")
            req.Header.Add("Content-Type", "application/json")

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
        RequestBody body = RequestBody.create(mediaType, "{\"deleteSchema\": true}");

        Request request = new Request.Builder()
            .url("https://api.flotiq.com/api/v1/internal/contenttype/blogposts/purge")
            .post(body)
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();

        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"

        ```
        HttpResponse<String> response = Unirest.post("https://api.flotiq.com/api/v1/internal/contenttype/blogposts/purge")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .body("{\"deleteSchema\": true}")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"

        ```
        const request = require('request');

        const options = {
            method: 'POST',
            url: 'https://api.flotiq.com/api/v1/internal/contenttype/blogposts/purge',
            headers: {
                'X-AUTH-TOKEN': 'YOUR_API_KEY',
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ deleteSchema: true }),
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/internal/contenttype/blogposts/purge",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS => "{\"deleteSchema\": true}",
            CURLOPT_HTTPHEADER => [
                "Content-Type: application/json",
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

        Returned when the schema has been removed

    === "401 Unauthorized"

        Returned when API key was missing or incorrect

        ```
        {
            "code": 401,
            "message": "Unauthorized"
        }
        ```
        { data-search-exclude }

    === "404 Not found"

        Returned when the schema wasn't found

        ```
        {
            "code": 404,
            "message": "Not found"
        }
        ```
        { data-search-exclude }

## Deleting Content Types through the Content modeller

If you'd rather use our graphical interface to delete your Content Types - read the [Content modeller documentation](/docs/panel/content-types/)


## Related docs

- [Content Objects](../content-objects.md)
- [Content Types](../content-types.md)
- [Dynamic Content API](../dynamic-content-api.md)
- [API access & scoped keys](../index.md)

[Register to send all requests with your own API today](https://editor.flotiq.com/register?plan=1ef44daa-fdc3-6790-960e-cb20a0848bfa){: .flotiq-button}
