---
tags:
  - Developer
---

title: How to list Content Type Definitions | Flotiq docs
description: How to list Content Type Definitions in Flotiq

# Listing Content Types

To get the list of
<abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Types</abbr>
you need to send `GET` call to `/api/v1/internal/contenttype`.
It returns a paginated list of Content Types defined for your account. It can be filtered and limited.

!!! note
    You can use your `Application Read Only API KEY` to perform this action. Read more about [API keys and scoped API keys](/docs/API/).


Possible request parameters:

| Parameter       | Description                                                                                                                                           |
| --------------- |-------------------------------------------------------------------------------------------------------------------------------------------------------|
| limit           | Number of objects on page, default `20`                                                                                                               |
| page            | Number of the requested page, 1-based, default `1`                                                                                                    |
| order_by        | What field should list be ordered by, possible values: `name`, `id`, `createdAt`, `updatedAt`, default `name`                                         |
| order_direction | Order direction, possible values: `asc`, `desc`, default `asc`                                                                                        |
| name            | Used for filtering Content Types by name, filtering is case insensitive and returns everything containing parameter value, default empty              |
| names           | Used for filtering Content Types by names, filtering is case insensitive and returns everything what is equal to values from parameter, default empty |
| label           | Used for filtering Content Types by label, filtering is case insensitive and returns everything containing parameter value, default empty             |

!!! Example

    === "CURL"

        ``` 
        curl --location --request GET "https://api.flotiq.com/api/v1/internal/contenttype?page=1&limit=20&order_by=name&order_direction=asc&name=blog" \
        --header "X-AUTH-TOKEN: YOUR_API_KEY" \
        --header "accept: application/json"
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/internal/contenttype?page=1&limit=20&order_by=name&order_direction=asc&name=blog");
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
        
            url := "https://api.flotiq.com/api/v1/internal/contenttype?page=1&limit=20&order_by=name&order_direction=asc&name=blog"
        
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
            .url("https://api.flotiq.com/api/v1/internal/contenttype?page=1&limit=20&order_by=name&order_direction=asc&name=blog")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/internal/contenttype?page=1&limit=20&order_by=name&order_direction=asc&name=blog")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'GET',
            url: 'https://api.flotiq.com/api/v1/internal/contenttype',
            qs: {
                page: '1',
                limit: '20',
                order_by: 'name',
                order_direction: 'asc',
                name: 'blog'
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/internal/contenttype?page=1&limit=20&order_by=name&order_direction=asc&name=blog",
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

!!! Responses

    === "200 OK"

        ```
        {
          "total_count": 2,
          "total_pages": 1,
          "current_page": 1,
          "count": 2,
          "data": [
            {
              "id": "1e64237a-f4db-11e9-991e-d2c03bd6f499",
              "name": "_media",
              "label": "Media",
              "schemaDefinition": {
                "type": "object",
                "allOf": [
                  {
                    "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
                  },
                  {
                    "type": "object",
                    "properties": {
                      "url": {
                        "type": "string",
                        "minLength": 1
                      },
                      "size": {
                        "type": "number",
                        "minLength": 1
                      },
                      "type": {
                        "type": "string",
                        "minLength": 1
                      },
                      "width": {
                        "type": "number"
                      },
                      "height": {
                        "type": "number"
                      },
                      "source": {
                        "type": "string",
                        "minLength": 1
                      },
                      "fileName": {
                        "type": "string",
                        "minLength": 1
                      },
                      "mimeType": {
                        "type": "string",
                        "minLength": 1
                      },
                      "extension": {
                        "type": "string",
                        "minLength": 1
                      },
                      "externalId": {
                        "type": "string"
                      }
                    }
                  }
                ],
                "required": [
                  "fileName",
                  "mimeType",
                  "size",
                  "url",
                  "source",
                  "extension",
                  "type"
                ],
                "additionalProperties": false
              },
              "metaDefinition": {
                "order": [
                  "fileName",
                  "mimeType",
                  "size",
                  "width",
                  "height",
                  "url",
                  "externalId",
                  "source",
                  "extension",
                  "type"
                ],
                "propertiesConfig": {
                  "url": {
                    "label": "Url",
                    "unique": false,
                    "inputType": "text"
                  },
                  "size": {
                    "label": "Size",
                    "unique": false,
                    "inputType": "number"
                  },
                  "type": {
                    "label": "Type",
                    "unique": false,
                    "options": [
                      "image",
                      "file"
                    ],
                    "inputType": "select"
                  },
                  "width": {
                    "label": "Width",
                    "unique": false,
                    "inputType": "number"
                  },
                  "height": {
                    "label": "Height",
                    "unique": false,
                    "inputType": "number"
                  },
                  "source": {
                    "label": "Source",
                    "unique": false,
                    "options": [
                      "disk",
                      "unsplash"
                    ],
                    "inputType": "select"
                  },
                  "fileName": {
                    "label": "File name",
                    "unique": false,
                    "inputType": "text",
                    "isTitlePart": true
                  },
                  "mimeType": {
                    "label": "MIME type",
                    "unique": false,
                    "inputType": "text"
                  },
                  "extension": {
                    "label": "Extension",
                    "unique": false,
                    "inputType": "text"
                  },
                  "externalId": {
                    "label": "External id",
                    "unique": false,
                    "inputType": "text"
                  }
                }
              },
              "deletedAt": null,
              "createdAt": "2019-10-22T14:49:15.000000+0000",
              "updatedAt": "2020-20-07T16:33:47.000000+0000"
            },
            {
              "id": "77721433-f727-11e9-bf7c-129df7ebe82d",
              "name": "blogposts",
              "label": "Blog Posts",
              "schemaDefinition": {
                "type": "object",
                "allOf": [
                  {
                    "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
                  },
                  {
                    "type": "object",
                    "properties": {
                      "title": {
                        "type": "string",
                        "minLength": 1
                      },
                      "postContent": {
                        "type": "string",
                        "minLength": 1
                      }
                    }
                  }
                ],
                "required": [
                  "title",
                  "postContent"
                ],
                "additionalProperties": false
              },
              "metaDefinition": {
                "propertiesConfig": {
                  "title": {
                    "label": "Title",
                    "inputType": "text",
                    "unique": true
                  },
                  "postContent": {
                    "label": "Post content",
                    "inputType": "richtext",
                    "unique": false
                  }
                },
                "order": [
                  "title",
                  "postContent"
                ]
              },
              "deletedAt": null,
              "createdAt": "2019-10-25T13:00:50.000000+0000",
              "updatedAt": "2020-07-20T16:34:11.000000+0000"
            }
          ]
        }
        ```
        { data-search-exclude }

        `total_count` is the number of Content Types in the database (if any filters are present, it's a number of filtered Content Types).
        
        `total_pages` is the number of pages available to the user.
        
        `current_page` is the currently returned page.
        
        `count` number of elements in `data` key; can't be more than limit set in request (default 20).
        
        `data` list of Content Types, every object contains all data.

    === "401 Unauthorized"

        Returned when API key was missing or incorrect
  
        ```
        {
            "code": 401,
            "massage": "Unauthorized"
        }
        ```
        { data-search-exclude }

[Register to send all requests with your own API today](https://editor.flotiq.com/register.html){: .flotiq-button}
