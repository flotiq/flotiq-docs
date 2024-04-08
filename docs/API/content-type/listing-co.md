title: How to list Content Objects | Flotiq docs
description: How to list Content Objects in Flotiq

# Listing content

Once a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr>
has been defined in the system - the user can list
<abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr>  of that Content Type.
This is done either directly through the API or via the convenient Content Entry tools provided within the
Content Management Platform.

!!! note
    You can use your `Application Read Only API KEY` to perform this action
    or `User API KEY` scoped to accept read on the Content Type you wish to list.
    Read more about [API keys and scoped API keys](/docs/API/).

## Listing content through the API

For a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr>
defined according to the [create Content Type example](/docs/API/content-type/creating-ctd), a very simple `GET` request can be sent
to the supporting endpoint `https://api.flotiq.com/api/v1/content/{name}`
(where `name` is the name of the content type definition) to get Content Objects.

This is a basic request for listing content, without any additional parameters:

!!! Example

    === "CURL"

        ``` 
        curl GET "https://api.flotiq.com/api/v1/content/blogposts" \
        --header "X-AUTH-TOKEN: YOUR_API_KEY" \
        --header "accept: application/json"
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts");
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
        
            url := "https://api.flotiq.com/api/v1/content/blogposts"
        
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
            .url("https://api.flotiq.com/api/v1/content/blogposts")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/blogposts")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'GET',
            url: 'https://api.flotiq.com/api/v1/content/blogposts',
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts",
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
        { data-search-exclude }

The example below shows the use of multiple parameters in one complex API query.
In the order of the parameters, we first specify the `page` of results,
the `limit` how many results to show per page, what field to `order_by`,
in what `order_direction`, whether to use `hydration`, and what `filters` to narrow the response:

!!! Example

    === "CURL"
        ``` 
        curl "https://api.flotiq.com/api/v1/content/blogposts" \
        --get \
        --data "page=1" \
        --data "limit=20" \
        --data "order_by=internal.createdAt" \
        --data "order_direction=asc" \
        --data "hydrate=0" \
        --data-urlencode 'filters={"title":{"type":"equals","filter":"Hello world"}}' \
        --header "X-AUTH-TOKEN: YOUR_API_KEY" \
        --header "accept: application/json"
        ```
        { data-search-exclude }

        Inline version (notice urlencoded `filters` parameter)
        ``` 
        curl "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22Hello%20world%22%7D%7D" \
        --header "X-AUTH-TOKEN: YOUR_API_KEY" \
        --header "accept: application/json"
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22Hello%20world%22%7D%7D");
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
        
            url := "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22Hello%20world%22%7D%7D"
        
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
            .url("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22Hello%20world%22%7D%7D")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22Hello%20world%22%7D%7D")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'GET',
            url: 'https://api.flotiq.com/api/v1/content/blogposts',
            qs: {
                page: '1',
                limit: '20',
                order_by: 'internal.createdAt',
                order_direction: 'asc',
                hydrate: '0',
                filters: JSON.stringify({"title":{"type":"equals","filter":"Hello world"}})
            },
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22Hello%20world%22%7D%7D",
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
        { data-search-exclude }



Request parameters

| Parameter       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| limit           | Number of objects on page, default `20`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| page            | Number of the requested page, 1-based, default `1`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| order_by        | What field should the list be ordered by, possible values are based on content type schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| order_direction | Order direction, possible values: `asc`, `desc`, default `asc`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| hydrate         | If you want to hydrate data sources in the object, you need to set it to `1`, it will hydrate one level of data sources in objects, `2` will hydrate deeper objects, and it's the highest level of hydration available in Flotiq API. You can also use this parameter when requesting a single object                                                                                                                                                                                                                                                                                                                                                              |
| filters         | Json encoded object containing conditions on which the list of CO should be filtered. |

!!! Responses

    === "200 OK"

        Returned when the request was correctly formatted

        ```
        {
          "total_count": 1,
          "total_pages": 1,
          "current_page": 1,
          "count": 1,
          "data": [
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
          ]
        }
        ```
        { data-search-exclude }

        `total_count` is the number of Content Objects in the database (if any filters are present, it's a number of filtered Content Objects).
        
        `total_pages` is the number of pages available to the user.
        
        `current_page` is the currently returned page.
        
        `count` number of elements in `data` key; can't be more than limit set in request (default 20).
        
        `data` list of Content Objects, every object contains all data.

    === "400 Validation error"

        Returned when data has not been correct, and the object was not saved

        ```
        {
            "filters": [
                "Malformed filters json - Syntax error"
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

        Returned when content type definition wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```
        { data-search-exclude }

### Filtering data

In order to filter the listed data, you can specify the `filters` parameter, which accepts JSON-encoded object specifying filtering conditions for the list of CO.

The object keys are the name of the parameter (e.g. title). The object value is a filter object with two keys, type describing how the list should be filtered and filter with filter query. Both parameters should be a string; you can filter on every subset of object parameters, including internal parameters (e.g. internal.created_at). Filters must be url encoded.

Example filter value: `{"title":{"type":"equals","filter":"Hello world!"}}`

Filters can accept the following filter types:

- equals
- notEqual
- contains
- notContains
- startsWith
- endsWith
- lessThanOrEqual
- lessThan
- greaterThanOrEqual
- greaterThan
- inRange
- empty
- notEmpty

You can check the example for each filter usage below:

!!! Example

    === "equals"
    
        Object parameter must be equal to `filter`

        Can be used with every type
        
        Example:
        
        `filters={"price":{"type":"equals","filter":50}}`

        Will return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "notEqual"
    
        Object parameter must not be equal to `filter`

        Can be used with every type

        Example:
        
        `filters={"price":{"type":"notEqual","filter":50}}`

        Will return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "contains"
    
        Object parameter must contain `filter`

        Can be used with every type

        Example:
        
        `filters={"title":{"type":"contains","filter":"-1"}}`

        Will return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "notContains"
    
        Object parameter must not contain `filter`

        Can be used with every type

        Example:
        
        `filters={"title":{"type":"notContains","filter":"-1"}}`

        Will return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "startsWith"
    
        Object parameter must start with `filter`

        Can be used with string type parameters

        Example:
        
        `filters={"id":{"type":"startsWith","filter":"1-"}}`

        Will return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "endsWith"
    
        Object parameter must end with `filter`

        Can be used with string type parameters

        Example:
        
        `filters={"title":{"type":"endsWith","filter":"-1"}}`

        Will return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "lessThanOrEqual"
    
        Object parameter must be less or equal to `filter`

        Can be used with number and date type parameters

        Example:
        
        `filters={"price":{"type":"lessThanOrEqual","filter":100}}`

        Will return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        },
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "lessThan"
    
        Object parameter must be less than a filter

        Can be used with number and date type parameters

        Example:
        
        `filters={"price":{"type":"lessThan","filter":100}}`

        Will return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "greaterThanOrEqual"
    
        Object parameter must be greater or equal than `filter`

        Can be used with number and date type parameters

        Example:
        
        `filters={"price":{"type":"greaterThanOrEqual","filter":100}}`

        Will return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "greaterThan"
    
        Object parameter must be greater than `filter`

        Can be used with number and date type parameters

        Example:
        
        `filters={"price":{"type":"greaterThan","filter":100}}`

        Will return:

        ```
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        },
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "inRange"
    
        Object parameter must be between `filter` and `filter2`, it is only filter type that has three keys in filter object

        Can be used with number and date type parameters

        Example:
        
        `filters={"price":{"type":"inRange","filter":75, "filter2":125}}`

        Will return:

        
        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "product-1",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "empty"
    
        Object parameter does not exist or is an empty string or array; the `filter` parameter is ignored

        Can be used with every type.

        Example:
        
        `filters={"title":{"type":"empty"}}`

        Will return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }
    
    === "notEmpty"
    
        Object parameter exists and is not an empty string or array; the `filter` parameter is ignored.

        Can be used with every type.

        Example:
        
        `filters={"title":{"type":"notEmpty"}}`

        Will return:

        ```
        {
            "id": "2-id",
            "price": 100,
            "title": "product-2",
            "internal": {...}
        },
        {
            "id": "3-id",
            "price": 150,
            "title": "product-3",
            "internal": {...}
        }
        ```
        { data-search-exclude }

        Will not return:

        ```
        {
            "id": "1-id",
            "price": 50,
            "title": "",
            "internal": {...}
        }
        ```
        { data-search-exclude }

!!! Note
    The equals and notEquals filters allow passing multiple elements so that the results are equal to any of them, for example:<br>
        `{"name":{"type":"equals", "filter":["product-1", "product-2"]}}` <br>
    or: <br>
        `{"name":{"type":"notEquals", "filter":["product-1", "product-2"]}}`

!!! Example

    ```
    {
        "title": {
            "type": "equals",
            "filter": "New object"
        },
        "postContent": {
            "type": "contains",
            "filter": "content"
        }
    }
    ```
    { data-search-exclude }

    === "CURL"
    
        ```
        curl -X GET "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D" -H "X-AUTH-TOKEN: YOUR_API_KEY" -H "accept: application/json"
        ```
        { data-search-exclude }
        
    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D");
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
        
            url := "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D"
        
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
            .url("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'GET',
            url: 'https://api.flotiq.com/api/v1/content/blogposts',
            qs: {
                page: '1',
                limit: '20',
                order_by: 'internal.createdAt',
                order_direction: 'asc',
                hydrate: '0',
                filters: '{"title":{"type":"equals","filter":"New object"},"postContent":{"type":"contains","filter":"content"}}'
            },
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
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

### Possible validation errors

| Error                                 | Description                                      |
| ------------------------------------- | ------------------------------------------------ |
| Malformed filters json - Syntax error | Send when filters are not correctly json encoded |

### Filtering by relation

For example, "Show products in category category-1" is possible using [JsonPath](https://github.com/json-path/JsonPath) standard.
You have to care about encoding url params. For example:

1. Using JsonPath, product category path is `categories[*].dataUrl`
1. Expected value is `/api/v1/content/categories/category-1`
1. Raw query: `GET /api/v1/content/products?filters={"categories[*].dataUrl":{"type":"contains","filter":"/api/v1/content/categories/category-1"}}`
1. Encoded query: `GET /api/v1/content/products?filters=%7B%22categories%5B%2A%5D.dataUrl%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22%2Fapi%2Fv1%2Fcontent%2Fcategories%2Fcategory-1%22%7D%7D`

Only `contains` and `notContains` type filters can be used with filtering by relation.

!!! Note
    Even if you list your content objects with hydration enabled, you cannot filter them by the hydrated data.

    For example if a Content Type "Blog Post" has relation to another type "Author", and you want to filter by `Author.name`, and use `hydrate=1` param to get authors data embedded in blog posts data, you still have to use filtering by dataUrl method described above.

### Hydrating objects

If you wish to receive underlying objects attached to the object you are retrieving, you need to send a request with query parameter `hydrate` set to `1`, if hydrated objects have other objects attached that you want to get access to, you can set `hydrate` to `2`.

!!! Note
    `hydrate=2` is the highest level of hydration available in Flotiq API.

**Below we show how you can, while fetching a product, display the name of its category, i.e. product -> category -> name - this is an ideal case for hydration.**

!!! Example

    === "CURL"

        ``` 
        curl -X GET "https://api.flotiq.com/api/v1/content/product?hydrate=1" -H "X-AUTH-TOKEN: YOUR_API_KEY" -H "accept: application/json"
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/product?hydrate=1");
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
        
            url := "https://api.flotiq.com/api/v1/content/product?hydrate=1"
        
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
            .url("https://api.flotiq.com/api/v1/content/product?hydrate=1")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/product?hydrate=1")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'DELETE',
            url: 'https://api.flotiq.com/api/v1/content/product',
            qs: {
                page: '1',
                limit: '20',
                order_by: 'internal.createdAt',
                order_direction: 'asc',
                hydrate: '1',
                filters: '{}'
            },
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/product?hydrate=1",
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

!!! Response - hydration enabled

    === "Hydration enabled"

        ```
        {
            "data": [{
                "id": "product-1",
                "name": "Wild fruit",
                "slug": "wild-fruit",
                "price": 12,
                "internal": {...},
                "description": "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc interdum erat vitae aliquet euismod. Curabitur hendrerit, eros sed iaculis aliquam, ante magna placerat ante, at fermentum augue nulla non justo. Curabitur arcu sem, venenatis eget lobortis a, aliquet nec nunc. Nam tristique, est ac dictum iaculis, mauris nunc pellentesque lacus, in pulvinar enim turpis in dolor. Morbi porta, mi vitae euismod volutpat, nisi sem mollis ligula, nec faucibus erat est vitae ante. Maecenas fringilla sodales tortor a varius. Fusce ipsum lorem, pharetra id tempus non, luctus in elit.</p>\n\n<p>Aliquam lectus arcu, accumsan quis libero vel, placerat faucibus orci. Aenean vitae mattis turpis, id egestas arcu. Integer non purus dui.</p>\n\n<ul>\n\t<li>Etiam porttitor massa id velit semper, vitae posuere leo egestas.</li>\n\t<li>Nunc congue, quam vestibulum cursus luctus, turpis sem feugiat odio, eu placerat ex tellus vitae elit.</li>\n\t<li>Phasellus sodales purus sed auctor feugiat. Morbi varius pretium ligula id semper. In ac scelerisque erat.</li>\n\t<li>Quisque a metus ut nibh finibus hendrerit.</li>\n</ul>\n\n<p>Nam in quam et libero mollis venenatis viverra a odio. Aenean in lacus id libero pretium scelerisque ac cursus est. Quisque egestas leo ut ex sollicitudin, at porta nunc tincidunt. Nulla posuere, enim eu commodo gravida, orci erat egestas lorem, sit amet imperdiet lectus massa quis libero. Maecenas a hendrerit nunc. Cras eu quam metus. Etiam volutpat, leo nec faucibus sollicitudin, sapien lacus bibendum lorem, maximus porttitor ligula tortor a orci. Aenean non diam ornare, condimentum nisi sed, viverra justo. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras commodo efficitur metus, in interdum purus. Cras sed risus eget arcu dapibus consequat. Aenean quis aliquam dia.</p>\n",
                "productImage": [{
                    "id": "_media-b35676ac-94f5-4200-9e16-eef40b649352",
                    "url": "/image/0x0/_media-b35676ac-94f5-4200-9e16-eef40b649352.jpg",
                    "size": 574633,
                    "type": "image",
                    "width": 1920,
                    "height": 1275,
                    "source": "disk",
                    "fileName": "_media-5e8d9bf8e731d.jpg",
                    "internal": {...},
                    "mimeType": "image/jpeg",
                    "extension": "jpg",
                    "externalId": ""
                }],
                "productGallery": [{
                    "id": "_media-b35676ac-94f5-4200-9e16-eef40b649352",
                    "url": "/image/0x0/_media-b35676ac-94f5-4200-9e16-eef40b649352.jpg",
                    "size": 574633,
                    "type": "image",
                    "width": 1920,
                    "height": 1275,
                    "source": "disk",
                    "fileName": "_media-5e8d9bf8e731d.jpg",
                    "internal": {...},
                    "mimeType": "image/jpeg",
                    "extension": "jpg",
                    "externalId": ""
                }]
            }]
        }
        ```
        { data-search-exclude }

    === "Hydration disabled"

        ```
        {
            "data": [{
                "id": "product-1",
                "name": "Wild fruit",
                "slug": "wild-fruit",
                "price": 12,
                "internal": {...},
                "description": "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc interdum erat vitae aliquet euismod. Curabitur hendrerit, eros sed iaculis aliquam, ante magna placerat ante, at fermentum augue nulla non justo. Curabitur arcu sem, venenatis eget lobortis a, aliquet nec nunc. Nam tristique, est ac dictum iaculis, mauris nunc pellentesque lacus, in pulvinar enim turpis in dolor. Morbi porta, mi vitae euismod volutpat, nisi sem mollis ligula, nec faucibus erat est vitae ante. Maecenas fringilla sodales tortor a varius. Fusce ipsum lorem, pharetra id tempus non, luctus in elit.</p>\n\n<p>Aliquam lectus arcu, accumsan quis libero vel, placerat faucibus orci. Aenean vitae mattis turpis, id egestas arcu. Integer non purus dui.</p>\n\n<ul>\n\t<li>Etiam porttitor massa id velit semper, vitae posuere leo egestas.</li>\n\t<li>Nunc congue, quam vestibulum cursus luctus, turpis sem feugiat odio, eu placerat ex tellus vitae elit.</li>\n\t<li>Phasellus sodales purus sed auctor feugiat. Morbi varius pretium ligula id semper. In ac scelerisque erat.</li>\n\t<li>Quisque a metus ut nibh finibus hendrerit.</li>\n</ul>\n\n<p>Nam in quam et libero mollis venenatis viverra a odio. Aenean in lacus id libero pretium scelerisque ac cursus est. Quisque egestas leo ut ex sollicitudin, at porta nunc tincidunt. Nulla posuere, enim eu commodo gravida, orci erat egestas lorem, sit amet imperdiet lectus massa quis libero. Maecenas a hendrerit nunc. Cras eu quam metus. Etiam volutpat, leo nec faucibus sollicitudin, sapien lacus bibendum lorem, maximus porttitor ligula tortor a orci. Aenean non diam ornare, condimentum nisi sed, viverra justo. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras commodo efficitur metus, in interdum purus. Cras sed risus eget arcu dapibus consequat. Aenean quis aliquam dia.</p>\n",
                "productImage": [{
                    "type": "internal",
                    "dataUrl": "/api/v1/content/_media/_media-b35676ac-94f5-4200-9e16-eef40b649352"
                }],
                "productGallery": [{
                    "type": "internal",
                    "dataUrl": "/api/v1/content/_media/_media-b35676ac-94f5-4200-9e16-eef40b649352"
                }]
            }]
        }
        ```
        { data-search-exclude }

As you can see after adding hydrate instead of `{dataUrl: ...}` we get a full object, so we can immediately show the values ​​without additional requests.

[Register to start creating your content objects](https://editor.flotiq.com/register.html){: .flotiq-button}
