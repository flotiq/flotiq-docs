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
    Read more about [API keys and scoped API keys](/API/).

## Listing content through the API

For a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr>
defined according to the [create Content Type example](/API/content-type/creating-ctd), a very simple `GET` request can be sent
to the supporting endpoint `https://api.flotiq.com/api/v1/content/{name}`
(where `name` is the name of the content type definition) to get Content Objects.

!!! Example

    === "CURL"

        ``` 
        curl --location --request GET "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%7D" \
        --header "X-AUTH-TOKEN: YOUR_API_KEY" \
        --header "accept: application/json"
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%7D");
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
        
            url := "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%7D"
        
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
            .url("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%7D")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%7D")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```

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
                filters: '{}'
            },
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%7D",
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

Request parameters

| Parameter       | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| limit           | Number of objects on page, default `20`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| page            | Number of the requested page, 1-based, default `1`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| order_by        | What field should the list be ordered by, possible values are based on content type schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| order_direction | Order direction, possible values: `asc`, `desc`, default `asc`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| hydrate         | If you want to hydrate data sources in the object, you need to set it to `1`, it will hydrate one level of data sources in objects; you can also use this parameter when requesting a single object                                                                                                                                                                                                                                                                                                                                                              |
| filters         | Json encoded object containing conditions on which the list of CO should be filtered. The object keys are the name of the parameter (e.g. `title`). The object value is a filter object with two keys, `type` describing how the list should be filtered and `filter` with filter query. Both parameters should be a string; you can filter on every subset of object parameters, including `internal` parameters (e.g. `internal.created_at`). Filters must be url encoded. <br><br>Example filter value: `{"title":{"type":"equals","filter":"Hello world!"}}` |

Filter types

| Type               | Description                                                                                                                                                   |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| equals             | Object parameter must be equal to `filter`, can be used with string type parameters                                                                           |
| notEquals          | Object parameter must not be equal to `filter`, can be used with string type parameters                                                                       |
| contains           | Object parameter must contain `filter`, can be used with every type parameters                                                                                |
| notContains        | Object parameter must not contain `filter`, can be used with every type parameters                                                                            |
| startsWith         | Object parameter must start with `filter`, can be used with string type parameters                                                                            |
| endsWith           | Object parameter must end with `filter`, can be used with string type parameters                                                                              |
| lessThanOrEqual    | Object parameter must be less or equal to `filter`, can be used with number type parameters                                                                   |
| lessThan           | Object parameter must be less than a filter, can be used with number type parameters                                                                          |
| greaterThanOrEqual | Object parameter must be greater or equal than `filter`, can be used with number type parameters                                                              |
| greaterThan        | Object parameter must be greater than `filter`, can be used with number type parameters                                                                       |
| inRange            | Object parameter must be between `filter` and `filter2`, it is only filter type that has three keys in filter object, can be used with number type parameters |

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

    === "CURL"
    
        ```
        curl -X GET "https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D" -H "X-AUTH-TOKEN: YOUR_API_KEY" -H "accept: application/json"
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D");
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

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/blogposts?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=0&filters=%7B%22title%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22New%20object%22%7D%2C%22postContent%22%3A%7B%22type%22%3A%22contains%22%2C%22filter%22%3A%22content%22%7D%7D")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```

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
            }
          ]
        }
        ```

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

    === "401 Unauthorized"

        Returned when API key was missing or incorrect
  
        ```
        {
            "code": 401,
            "massage": "Unauthorized"
        }
        ```

    === "404 Not found"

        Returned when content type definition wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```

#### Possible validation errors

| Error                                 | Description                                      |
| ------------------------------------- | ------------------------------------------------ |
| Malformed filters json - Syntax error | Send when filters are not correctly json encoded |

#### Filtering by relation

For example, "Show products in category category-1" is possible using [JsonPath](https://github.com/json-path/JsonPath) standard.
You have to care about encoding url params. For example:

1. Using JsonPath, product category path is `categories[*].dataUrl`
1. Expected value is `/api/v1/content/categories/category-1`
1. Raw query: `GET /api/v1/content/products?filters={"categories[*].dataUrl":{"type":"contains","filter":"/api/v1/content/categories/category-1"}}`
1. Encoded query: `GET /api/v1/content/products?filters=%7B%22categories%5B%2A%5D.dataUrl%22%3A%7B%22type%22%3A%22equals%22%2C%22filter%22%3A%22%2Fapi%2Fv1%2Fcontent%2Fcategories%2Fcategory-1%22%7D%7D`

Only `contains` and `notContains` type filters can be used with filtering by relation.

### Hydrating objects

If you wish to receive underlying objects attached to objects you are listing, you need to send a request with query parameter `hydrate` set to `1`.
There is only 1 level of hydration. The example below shows example response for products with a category, product image and product gallery.

!!! Example

    === "CURL"

        ``` 
        curl -X GET "https://api.flotiq.com/api/v1/content/product?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=1&filters=%7B%7D" -H "X-AUTH-TOKEN: YOUR_API_KEY" -H "accept: application/json"
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/product?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=1&filters=%7B%7D");
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
        
            url := "https://api.flotiq.com/api/v1/content/product?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=1&filters=%7B%7D"
        
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
            .url("https://api.flotiq.com/api/v1/content/product?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=1&filters=%7B%7D")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/product?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=1&filters=%7B%7D")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```

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
                hydrate: '0',
                filters: '{}'
            },
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/product?page=1&limit=20&order_by=internal.createdAt&order_direction=asc&hydrate=1&filters=%7B%7D",
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

!!! Response

    === "200 OK"

        ```
        {
          "total_count": 4,
          "total_pages": 1,
          "current_page": 1,
          "count": 4,
          "data": [
            {
              "id": "product-1",
              "name": "Wild fruit",
              "slug": "wild-fruit",
              "price": 12,
              "category": [
                {
                  "id": "category-2",
                  "name": "Black tea",
                  "slug": "black-tea",
                  "image": [
                    {
                      "type": "internal",
                      "dataUrl": "/api/v1/content/_media/_media-5eb3b2cb85196"
                    }
                  ],
                  "internal": {
                    "createdAt": "2020-05-07T07:03:52+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T08:29:14+00:00",
                    "contentType": "category",
                    "workflow_state": "saved"
                  }
                }
              ],
              "internal": {
                "createdAt": "2020-05-07T07:03:55+00:00",
                "deletedAt": "",
                "updatedAt": "2020-07-10T08:23:49+00:00",
                "contentType": "product",
                "workflow_state": "saved"
              },
              "description": "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc interdum erat vitae aliquet euismod. Curabitur hendrerit, eros sed iaculis aliquam, ante magna placerat ante, at fermentum augue nulla non justo. Curabitur arcu sem, venenatis eget lobortis a, aliquet nec nunc. Nam tristique, est ac dictum iaculis, mauris nunc pellentesque lacus, in pulvinar enim turpis in dolor. Morbi porta, mi vitae euismod volutpat, nisi sem mollis ligula, nec faucibus erat est vitae ante. Maecenas fringilla sodales tortor a varius. Fusce ipsum lorem, pharetra id tempus non, luctus in elit.</p>\n\n<p>Aliquam lectus arcu, accumsan quis libero vel, placerat faucibus orci. Aenean vitae mattis turpis, id egestas arcu. Integer non purus dui.</p>\n\n<ul>\n\t<li>Etiam porttitor massa id velit semper, vitae posuere leo egestas.</li>\n\t<li>Nunc congue, quam vestibulum cursus luctus, turpis sem feugiat odio, eu placerat ex tellus vitae elit.</li>\n\t<li>Phasellus sodales purus sed auctor feugiat. Morbi varius pretium ligula id semper. In ac scelerisque erat.</li>\n\t<li>Quisque a metus ut nibh finibus hendrerit.</li>\n</ul>\n\n<p>Nam in quam et libero mollis venenatis viverra a odio. Aenean in lacus id libero pretium scelerisque ac cursus est. Quisque egestas leo ut ex sollicitudin, at porta nunc tincidunt. Nulla posuere, enim eu commodo gravida, orci erat egestas lorem, sit amet imperdiet lectus massa quis libero. Maecenas a hendrerit nunc. Cras eu quam metus. Etiam volutpat, leo nec faucibus sollicitudin, sapien lacus bibendum lorem, maximus porttitor ligula tortor a orci. Aenean non diam ornare, condimentum nisi sed, viverra justo. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras commodo efficitur metus, in interdum purus. Cras sed risus eget arcu dapibus consequat. Aenean quis aliquam dia.</p>\n",
              "productImage": [
                {
                  "id": "_media-5eb3b2cb53e21",
                  "url": "/image/0x0/_media-5eb3b2cb53e21.jpg",
                  "size": 574633,
                  "type": "image",
                  "width": 1920,
                  "height": 1275,
                  "source": "disk",
                  "fileName": "_media-5e8d9bf8e731d.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                }
              ],
              "productGallery": [
                {
                  "id": "_media-5eb3b2cb53e21",
                  "url": "/image/0x0/_media-5eb3b2cb53e21.jpg",
                  "size": 574633,
                  "type": "image",
                  "width": 1920,
                  "height": 1275,
                  "source": "disk",
                  "fileName": "_media-5e8d9bf8e731d.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                },
                {
                  "id": "_media-5eb3b2cb94093",
                  "url": "/image/0x0/_media-5eb3b2cb94093.jpg",
                  "size": 415013,
                  "type": "image",
                  "width": 1920,
                  "height": 1259,
                  "source": "disk",
                  "fileName": "_media-5e8d9c642c913.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                },
                {
                  "id": "_media-5eb3b2cbd798a",
                  "url": "/image/0x0/_media-5eb3b2cbd798a.jpg",
                  "size": 384246,
                  "type": "image",
                  "width": 1920,
                  "height": 1280,
                  "source": "disk",
                  "fileName": "_media-5e8d9c6589de6.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                }
              ]
            },
            {
              "id": "product-2",
              "name": "Earl grey",
              "slug": "earl-grey-tea",
              "price": 10,
              "category": [
                {
                  "id": "category-2",
                  "name": "Black tea",
                  "slug": "black-tea",
                  "image": [
                    {
                      "type": "internal",
                      "dataUrl": "/api/v1/content/_media/_media-5eb3b2cb85196"
                    }
                  ],
                  "internal": {
                    "createdAt": "2020-05-07T07:03:52+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T08:29:14+00:00",
                    "contentType": "category",
                    "workflow_state": "saved"
                  }
                }
              ],
              "internal": {
                "createdAt": "2020-05-07T07:03:55+00:00",
                "deletedAt": "",
                "updatedAt": "2020-07-10T08:23:53+00:00",
                "contentType": "product",
                "workflow_state": "saved"
              },
              "description": "<p><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean molestie mollis vestibulum. Donec sit amet tortor augue. Morbi eleifend tristique diam, at congue lorem porttitor varius. </strong></p>\n\n<p>Phasellus vulputate, ante vitae pretium varius, ligula ipsum hendrerit turpis, quis hendrerit ipsum purus maximus ligula. Ut eget ornare nunc. Pellentesque lacinia enim sit amet sem cursus semper. Etiam semper gravida metus. Nunc feugiat ut diam eu auctor.</p>\n\n<p>Curabitur lorem ipsum, luctus ac felis ut, mattis gravida lectus. Praesent ornare purus ac pharetra scelerisque. Cras aliquam est at leo vestibulum ullamcorper. Fusce ultrices orci tellus, facilisis euismod lectus eleifend pharetra. Nunc at malesuada erat. Morbi pellentesque vulputate suscipit. Praesent lobortis velit quis gravida dignissim. Vestibulum venenatis velit rutrum, sodales magna vel, egestas augue.</p>\n",
              "productImage": [
                {
                  "id": "_media-5eb3b2cb85196",
                  "url": "/image/0x0/_media-5eb3b2cb85196.jpg",
                  "size": 252558,
                  "type": "image",
                  "width": 1920,
                  "height": 1435,
                  "source": "disk",
                  "fileName": "_media-5e8da15ac37fb.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                }
              ],
              "productGallery": [
                {
                  "id": "_media-5eb3b2cb85196",
                  "url": "/image/0x0/_media-5eb3b2cb85196.jpg",
                  "size": 252558,
                  "type": "image",
                  "width": 1920,
                  "height": 1435,
                  "source": "disk",
                  "fileName": "_media-5e8da15ac37fb.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                },
                {
                  "id": "_media-5eb3b2cb8da4a",
                  "url": "/image/0x0/_media-5eb3b2cb8da4a.jpg",
                  "size": 321813,
                  "type": "image",
                  "width": 1920,
                  "height": 1280,
                  "source": "disk",
                  "fileName": "_media-5e8da215d87df.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                }
              ]
            },
            {
              "id": "product-3",
              "name": "English breakfast",
              "slug": "english-breakfast",
              "price": 9,
              "category": [
                {
                  "id": "category-2",
                  "name": "Black tea",
                  "slug": "black-tea",
                  "image": [
                    {
                      "type": "internal",
                      "dataUrl": "/api/v1/content/_media/_media-5eb3b2cb85196"
                    }
                  ],
                  "internal": {
                    "createdAt": "2020-05-07T07:03:52+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T08:29:14+00:00",
                    "contentType": "category",
                    "workflow_state": "saved"
                  }
                }
              ],
              "internal": {
                "createdAt": "2020-05-07T07:03:55+00:00",
                "deletedAt": "",
                "updatedAt": "2020-07-10T08:23:57+00:00",
                "contentType": "product",
                "workflow_state": "saved"
              },
              "description": "<p>Donec placerat tortor tristique risus faucibus, in laoreet leo pharetra. In in tristique eros. Donec ut mattis lacus, id faucibus metus. Integer ac nisi orci. Proin a mauris risus. Donec viverra eget quam sit amet porta.</p>\n\n<p>Aenean luctus sapien id nibh accumsan, quis faucibus tellus sagittis. Nam luctus eleifend risus, sit amet auctor nulla malesuada vitae. Cras tristique posuere massa ut congue. Donec a congue justo. Integer eleifend finibus pulvinar.</p>\n\n<p>Pellentesque in mauris ac turpis fermentum tincidunt. Nam sodales luctus tellus, a molestie leo molestie nec. Vestibulum in urna ut tortor finibus placerat. Integer non venenatis dolor.</p>\n\n<p><strong>Maecenas iaculis turpis aliquam vestibulum rhoncus. Donec venenatis ipsum eu fermentum tincidunt. Nullam lacus eros, elementum gravida tristique at, semper sit amet urna.</strong></p>\n",
              "productImage": [
                {
                  "id": "_media-5eb3b2cb8a2e8",
                  "url": "/image/0x0/_media-5eb3b2cb8a2e8.jpg",
                  "size": 398714,
                  "type": "image",
                  "width": 1920,
                  "height": 1280,
                  "source": "disk",
                  "fileName": "_media-5e8d9cc689abd.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                }
              ],
              "productGallery": [
                {
                  "id": "_media-5eb3b2cb8a2e8",
                  "url": "/image/0x0/_media-5eb3b2cb8a2e8.jpg",
                  "size": 398714,
                  "type": "image",
                  "width": 1920,
                  "height": 1280,
                  "source": "disk",
                  "fileName": "_media-5e8d9cc689abd.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:40+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:40+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                },
                {
                  "id": "_media-5eb3b2cae1005",
                  "url": "/image/0x0/_media-5eb3b2cae1005.jpg",
                  "size": 218702,
                  "type": "image",
                  "width": 1920,
                  "height": 1279,
                  "source": "disk",
                  "fileName": "_media-5e8d9cde7dff9.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:39+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:39+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                }
              ]
            },
            {
              "id": "product-4",
              "name": "Green tea",
              "slug": "green-tea",
              "price": 15,
              "category": [
                {
                  "id": "category-1",
                  "name": "Green Tea",
                  "slug": "green-tea",
                  "image": [
                    {
                      "type": "internal",
                      "dataUrl": "/api/v1/content/_media/_media-5eb3b2cb8a2e8"
                    }
                  ],
                  "internal": {
                    "createdAt": "2020-05-07T07:03:52+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T08:29:14+00:00",
                    "contentType": "category",
                    "workflow_state": "saved"
                  }
                }
              ],
              "internal": {
                "createdAt": "2020-05-07T07:03:55+00:00",
                "deletedAt": "",
                "updatedAt": "2020-07-10T08:24:01+00:00",
                "contentType": "product",
                "workflow_state": "saved"
              },
              "description": "<p><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla commodo luctus tincidunt. Integer non nulla nibh. In hac habitasse platea dictumst. Aenean tempor odio ligula, at scelerisque lacus porta id. </strong></p>\n\n<p>Sed sit amet ullamcorper felis, id vulputate augue. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nunc felis magna, varius id blandit vel, semper in lectus. Aliquam ac volutpat nunc. Morbi mattis lectus nec urna posuere, vel porttitor sapien porta. Proin urna mi, pulvinar in blandit consectetur, tempus vitae augue.</p>\n\n<p>Ut dictum velit et nisl molestie condimentum. Donec quis tincidunt lorem, nec bibendum neque. Pellentesque dictum elementum congue. Etiam dolor diam, sagittis vitae gravida in, interdum vitae purus. Donec vel pretium nisl, eget venenatis arcu.</p>\n",
              "productImage": [
                {
                  "id": "_media-5eb3b2cb0ea0b",
                  "url": "/image/0x0/_media-5eb3b2cb0ea0b.jpg",
                  "size": 184308,
                  "type": "image",
                  "width": 1920,
                  "height": 1253,
                  "source": "disk",
                  "fileName": "_media-5e8d9d2594cf5.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:39+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:39+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                }
              ],
              "productGallery": [
                {
                  "id": "_media-5eb3b2cb0ea0b",
                  "url": "/image/0x0/_media-5eb3b2cb0ea0b.jpg",
                  "size": 184308,
                  "type": "image",
                  "width": 1920,
                  "height": 1253,
                  "source": "disk",
                  "fileName": "_media-5e8d9d2594cf5.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:39+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:39+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                },
                {
                  "id": "_media-5eb3b2cb20f2f",
                  "url": "/image/0x0/_media-5eb3b2cb20f2f.jpg",
                  "size": 502416,
                  "type": "image",
                  "width": 1920,
                  "height": 1440,
                  "source": "disk",
                  "fileName": "_media-5e8d9d5a5ab89.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:39+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:39+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                },
                {
                  "id": "_media-5eb3b2cb136b3",
                  "url": "/image/0x0/_media-5eb3b2cb136b3.jpg",
                  "size": 371512,
                  "type": "image",
                  "width": 1920,
                  "height": 1280,
                  "source": "disk",
                  "fileName": "_media-5e8d9d4338747.jpg",
                  "internal": {
                    "createdAt": "2020-05-07T07:03:39+00:00",
                    "deletedAt": "",
                    "updatedAt": "2020-05-07T07:03:39+00:00",
                    "contentType": "_media",
                    "workflow_state": "saved"
                  },
                  "mimeType": "image/jpeg",
                  "extension": "jpg",
                  "externalId": ""
                }
              ]
            }
          ]
        }
        ```

[Register to start creating your content objects](https://editor.flotiq.com/register.html){: .flotiq-button}
