---
tags:
  - Developer
---

title: How to get single Content Type Definitions | Flotiq docs
description: How to get single Content Type Definitions in Flotiq

# Getting single Content Type

To get a single
<abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> definition
you need to send a `GET` request to the `/api/v1/internal/contenttype/{name}` endpoint. It will return a full schema of that Content Type.

!!! note
    You can use your `Application Read Only API KEY` to perform this action. 
    Read more about [API keys and scoped API keys](/docs/API/).


Possible request parameters:

| Parameter    | Description                                                                                                                                                   |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| resolveRef   | Should the system resolve references done using $ref, default `false`                                                                                         |
| strictSchema | For compatibility with OpenAPI 3.0 - use `schema` property instead of `schemaDefinition`, default `false`, does not have effect when resolveRef is not `true` |

!!! Example

    === "CURL"

        ``` 
        curl --location --request GET "https://api.flotiq.com/api/v1/internal/contenttype/blogposts" \
        --header 'accept: */*' \
        --header 'X-AUTH-TOKEN: YOUR_API_KEY'
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/internal/contenttype/blogposts");
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
        
            url := "https://api.flotiq.com/api/v1/internal/contenttype/blogposts"
        
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
            .url("https://api.flotiq.com/api/v1/internal/contenttype/blogposts")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/internal/contenttype/blogposts")
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

        Returned when the content type was found

        ```
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
        ```
        { data-search-exclude }

    === "200 OK for resolveRef"

        Returned when the content type was found

        ```
        {
          "id": "77721433-f727-11e9-bf7c-129df7ebe82d",
          "name": "blogposts",
          "label": "Blog Posts",
          "schemaDefinition": {
            "type": "object",
            "properties": {
              "title": {
                "type": "string",
                "minLength": 1
              },
              "postContent": {
                "type": "string",
                "minLength": 1
              },
              "id": {
                "type": "string",
                "description": "Unique ID of the object"
              },
              "internal": {
                "type": "object",
                "description": "Immutable object containing system information, it will be automatically generated on object creation and regenerated on updates.",
                "additionalProperties": false,
                "required": [
                  "createdAt",
                  "updatedAt",
                  "deletedAt",
                  "contentType"
                ],
                "properties": {
                  "contentType": {
                    "type": "string",
                    "description": "Name of Content Type Definition of object"
                  },
                  "createdAt": {
                    "type": "string",
                    "description": "Date and time of creation of Content Object, in ISO 8601 date format"
                  },
                  "updatedAt": {
                    "type": "string",
                    "description": "Date and time of last update of Content Object, in ISO 8601 date format"
                  },
                  "deletedAt": {
                    "type": "string",
                    "description": "Date and time of deletion of Content Object, in ISO 8601 date format"
                  },
                  "workflow_state": {
                    "type": "string",
                    "description": "Information about object's current state in workflow"
                  }
                }
              }
            },
            "required": [
              "title",
              "postContent"
            ],
            "additionalProperties": false
          },
          "metaDefinition": {
            "order": [
              "title",
              "postContent"
            ],
            "propertiesConfig": {
              "title": {
                "label": "Title",
                "unique": true,
                "inputType": "text"
              },
              "postContent": {
                "label": "Post content",
                "unique": false,
                "inputType": "richtext"
              }
            }
          },
          "deletedAt": null,
          "createdAt": "2019-10-25T13:00:50.000000+0000",
          "updatedAt": "2020-07-20T16:34:11.000000+0000"
        }
        ```
        { data-search-exclude }

    === "200 OK for resolveRef and strictSchema"

        Returned when the content type was found

        ```
        {
          "schema": {
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
            },
            "required": [
              "title",
              "postContent"
            ]
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

        Returned when the schema wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```
        { data-search-exclude }

[Register to send all requests with your own API today](https://editor.flotiq.com/register?plan=1ef44daa-fdc3-6790-960e-cb20a0848bfa){: .flotiq-button}
