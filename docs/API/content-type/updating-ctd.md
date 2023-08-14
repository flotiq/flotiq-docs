title: How to update Content Type Definitions | Flotiq docs
description: How to update Content Type Definitions in Flotiq API

# Updating Content Types

Existing <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content
Type</abbr>
can be updated either by sending a properly formatted PUT request to the ``/api/v1/internal/contenttype/{name}``
endpoint or through the Content Modeler tool provided with the platform.

!!! note
    You will need to use your `Application Read and write API KEY` to perform this action. 
    Read more about [API keys and scoped API keys](/docs/API/).

!!! warning
    Changes made to the Content Type Definition may lead to problems with programs and pages 
    already using this CTD if they break compatibility. 
    We strongly suggest only apply non-breaking changes to existing CTDs.

## Updating Content Types via API

Updating <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">
Content Type</abbr> is simply a ``PUT`` call with a payload similar to:

```
{
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
    }
}
```

You can find description of the schema [here](/docs/API/content-type/creating-ctd/#creating-new-content-types-via-api)

!!! tip
    After every change in Content Definition Schema Flotiq automatically updates your API documentation and Elastic Search
    index attached to this type. This means your API docs will always stay up to date with your current schema, and so will
    the results of the [full-text search feature](/docs/API/search/).

## What happens if you add a new property?

When you are adding new properties, objects already in the system will not have that property present until added by you.

## What happens if you remove a property?

If you remove the property, all objects will be stripped of that property's value after schema would be saved.

## What happens if you change a property?

When you change existing property, depending on the type of changes, Flotiq will:

* Do nothing with your data if changes are made to
  `label`, `isTitlePart`, `unique`, `required`, `pattern`, `options` or `default` properties
* Try to convert data if the changes are made to `type` or `inputType` properties if data will not be preserved, and
  the property is required, update of the CTD will not succeed (more in [conversion table](#how-are-fields-converted-from-one-type-to-another))
* Remove data attached to old property name when `name` of the property was changed; objects will not have a property with
  the new name present as in adding a new property

!!! warning
    When updating Content Definition Schema, you must remember that Flotiq will try to update objects of that
    type to reflect changes in the schema, which can result in data loss, if the old types and new types of
    the properties are not compatible.


!!! Example

    === "CURL"
    
        ```
        curl --location --request PUT "https://api.flotiq.com/api/v1/internal/contenttype/blogposts" \
        --header 'X-AUTH-TOKEN: YOUR_API_KEY' \
        --header 'Content-Type: application/json' \
        --header 'Accept: */*' \
        --data-raw '{
            "name":"blogpost",
            "label":"Blog Posts",
            "schemaDefinition":{
                "type":"object",
                "allOf":[{
                    "$ref":"#/components/schemas/AbstractContentTypeSchemaDefinition"
                    },{
                    "type":"object",
                    "properties":{
                        "title":{"type":"string"},
                        "postContent":{"type":"string"}}}
                ],
                "required":["title","postContent"],
                "additionalProperties":false
            },
            "metaDefinition":{
                "propertiesConfig":{
                    "title":{
                        "label":"Title",
                        "inputType":"text",
                        "unique":true},
                    "postContent":{
                        "label":"Post content",
                        "inputType":"richtext",
                        "unique":false}},
                "order":["title","postContent"]}
        }'
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/internal/contenttype/blogposts");
        var request = new RestRequest(Method.PUT);
        request.AddHeader("content-type", "application/json");
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        request.AddParameter("application/json", "{\"name\":\"blogposts\",\"label\":\"Blog Posts\",\"schemaDefinition\":{\"type\":\"object\",\"allOf\":[{\"$ref\":\"#/components/schemas/AbstractContentTypeSchemaDefinition\"},{\"type\":\"object\",\"properties\":{\"title\":{\"type\":\"string\"},\"postContent\":{\"type\":\"string\"}}}],\"required\":[\"title\",\"postContent\"],\"additionalProperties\":false},\"metaDefinition\":{\"propertiesConfig\":{\"title\":{\"label\":\"Title\",\"inputType\":\"text\",\"unique\":true},\"postContent\":{\"label\":\"Post content\",\"inputType\":\"richtext\",\"unique\":false}},\"order\":[\"title\",\"postContent\"]}}", ParameterType.RequestBody);
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
        
            url := "https://api.flotiq.com/api/v1/internal/contenttype/blogposts"
        
            payload := strings.NewReader("{\"name\":\"blogposts\",\"label\":\"Blog Posts\",\"schemaDefinition\":{\"type\":\"object\",\"allOf\":[{\"$ref\":\"#/components/schemas/AbstractContentTypeSchemaDefinition\"},{\"type\":\"object\",\"properties\":{\"title\":{\"type\":\"string\"},\"postContent\":{\"type\":\"string\"}}}],\"required\":[\"title\",\"postContent\"],\"additionalProperties\":false},\"metaDefinition\":{\"propertiesConfig\":{\"title\":{\"label\":\"Title\",\"inputType\":\"text\",\"unique\":true},\"postContent\":{\"label\":\"Post content\",\"inputType\":\"richtext\",\"unique\":false}},\"order\":[\"title\",\"postContent\"]}}")
        
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
    
    === "Java + Okhttp"
        
        ```
        OkHttpClient client = new OkHttpClient();

        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, "{\"name\":\"blogposts\",\"label\":\"Blog Posts\",\"schemaDefinition\":{\"type\":\"object\",\"allOf\":[{\"$ref\":\"#/components/schemas/AbstractContentTypeSchemaDefinition\"},{\"type\":\"object\",\"properties\":{\"title\":{\"type\":\"string\"},\"postContent\":{\"type\":\"string\"}}}],\"required\":[\"title\",\"postContent\"],\"additionalProperties\":false},\"metaDefinition\":{\"propertiesConfig\":{\"title\":{\"label\":\"Title\",\"inputType\":\"text\",\"unique\":true},\"postContent\":{\"label\":\"Post content\",\"inputType\":\"richtext\",\"unique\":false}},\"order\":[\"title\",\"postContent\"]}}");
        Request request = new Request.Builder()
            .url("https://api.flotiq.com/api/v1/internal/contenttype/blogposts")
            .put(body)
            .addHeader("content-type", "application/json")
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.put("https://api.flotiq.com/api/v1/internal/contenttype/blogposts")
            .header("content-type", "application/json")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .body("{\"name\":\"blogposts\",\"label\":\"Blog Posts\",\"schemaDefinition\":{\"type\":\"object\",\"allOf\":[{\"$ref\":\"#/components/schemas/AbstractContentTypeSchemaDefinition\"},{\"type\":\"object\",\"properties\":{\"title\":{\"type\":\"string\"},\"postContent\":{\"type\":\"string\"}}}],\"required\":[\"title\",\"postContent\"],\"additionalProperties\":false},\"metaDefinition\":{\"propertiesConfig\":{\"title\":{\"label\":\"Title\",\"inputType\":\"text\",\"unique\":true},\"postContent\":{\"label\":\"Post content\",\"inputType\":\"richtext\",\"unique\":false}},\"order\":[\"title\",\"postContent\"]}}")
            .asString();
        ```

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'PUT',
            url: 'https://api.flotiq.com/api/v1/internal/contenttype/blogposts',
            headers: {'content-type': 'application/json', 'X-AUTH-TOKEN': 'YOUR_API_KEY'},
            body: {
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
                }
            },
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
            CURLOPT_URL => "https://api.flotiq.com/api/v1/internal/contenttype/blogposts",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "PUT",
            CURLOPT_POSTFIELDS => "{\"name\":\"blogposts\",\"label\":\"Blog Posts\",\"schemaDefinition\":{\"type\":\"object\",\"allOf\":[{\"$ref\":\"#/components/schemas/AbstractContentTypeSchemaDefinition\"},{\"type\":\"object\",\"properties\":{\"title\":{\"type\":\"string\"},\"postContent\":{\"type\":\"string\"}}}],\"required\":[\"title\",\"postContent\"],\"additionalProperties\":false},\"metaDefinition\":{\"propertiesConfig\":{\"title\":{\"label\":\"Title\",\"inputType\":\"text\",\"unique\":true},\"postContent\":{\"label\":\"Post content\",\"inputType\":\"richtext\",\"unique\":false}},\"order\":[\"title\",\"postContent\"]}}",
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

        Returned when the schema has been correct and was saved

        ```
        {
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
            }
        }
        ```

    === "400 Validation error"

        Returned when the schema has not been correct and wasn't saved

        ```
        {
            "name": [
                "This value is already used."
            ],
            "label": [
                "Must be at least 1 characters long"
            ],
            "schemaDefinition.allOf[1].properties.title.type": [
                "Does not have a value in the enumeration [\"array\",\"boolean\",\"integer\",\"null\",\"number\",\"object\",\"string\"]",
                "String value found, but an array is required",
                "Failed to match at least one schema"
            ],
            "metaDefinition.propertiesConfig.price.label": [
                "The property label is required"
            ],
            "metaDefinition.propertiesConfig.price.inputType": [
                "Does not have a value in the enumeration [\"text\",\"richtext\",\"textarea\",\"textMarkdown\",\"email\",\"number\",\"radio\",\"checkbox\",\"select\",\"datasource\",\"object\",\"geo\"]"
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

#### Possible validation errors

Possible validation errors resemble those encountered when creating Content Types.
You can find the list [here](/docs/API/content-type/creating-ctd/#possible-validation-errors).

Validation can also fail when updating the schema by modifying required fields or changing field types.

### Updating Schema and Modifying Required Fields

When you modify a schema, any associated objects undergo a transformation process. This process ensures that the objects conform to the new schema's structure. However, there are certain considerations to keep in mind:

1. Required Fields: If a field is marked as "required" in the schema, the system expects all existing objects to have a value for that field. The transformation will fail during the conversion process if an existing object lacks a value for a newly marked required field.
2. Changing Field Types: If you change the data type of a field, particularly from one type to another, that cannot be automatically transformed (e.g., from "Text" to "Relationship"), updating existing objects automatically becomes challenging.

When encountering issues during schema conversion, you might receive error messages like the following:

!!! Responses

    === "400 Validation error"

        Returned when the schema has not been correct and wasn't saved

        ```
        {
            "fieldName":["The property fieldName is required"],
            "name":["Existing objects do not conform to the new schema, and updating them automatically is impossible (e.g., Text -> Relationship). Ensure you're not changing a field type that is also required - if so, disable required for the field you're changing."]
        }
        ```

### How are fields converted from one type to another?

| Old Type (type/inputType) | New Type (type/inputType) | Conversion                                                   |
| ------------------------- | ------------------------- | ------------------------------------------------------------ |
| string/text               | string/textarea           | Data are preserved                                           |
| string/text               | string/markdown           | Data are preserved                                           |
| string/text               | string/richtext           | Data are preserved                                           |
| string/text               | string/email              | Data are preserved                                           |
| string/text               | number/number             | All objects gets `0` value                                   |
| string/text               | string/radio              | Data are preserved                                           |
| string/text               | boolean/checkbox          | All objects gets `false` value                               |
| string/text               | string/select             | Data are preserved                                           |
| string/text               | array/object              | All object gets empty array                                  |
| string/text               | array/datasource          | All object gets empty array                                  |
| string/text               | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| string/textarea           | string/text               | Data are preserved                                           |
| string/textarea           | string/markdown           | Data are preserved                                           |
| string/textarea           | string/richtext           | Data are preserved                                           |
| string/textarea           | string/email              | Data are preserved                                           |
| string/textarea           | number/number             | All objects gets `0` value                                   |
| string/textarea           | string/radio              | Data are preserved                                           |
| string/textarea           | boolean/checkbox          | All objects gets `false` value                               |
| string/textarea           | string/select             | Data are preserved                                           |
| string/textarea           | array/object              | All object gets empty array                                  |
| string/textarea           | array/datasource          | All object gets empty array                                  |
| string/textarea           | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| string/markdown           | string/text               | Data are preserved                                           |
| string/markdown           | string/textarea           | Data are preserved                                           |
| string/markdown           | string/richtext           | Data are preserved                                           |
| string/markdown           | string/email              | Data are preserved                                           |
| string/markdown           | number/number             | All objects gets `0` value                                   |
| string/markdown           | string/radio              | Data are preserved                                           |
| string/markdown           | boolean/checkbox          | All objects gets `false` value                               |
| string/markdown           | string/select             | Data are preserved                                           |
| string/markdown           | array/object              | All object gets empty array                                  |
| string/markdown           | array/datasource          | All object gets empty array                                  |
| string/markdown           | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| string/richtext           | string/text               | Data are preserved                                           |
| string/richtext           | string/textarea           | Data are preserved                                           |
| string/richtext           | string/markdown           | Data are preserved                                           |
| string/richtext           | string/email              | Data are preserved                                           |
| string/richtext           | number/number             | All objects gets `0` value                                   |
| string/richtext           | string/radio              | Data are preserved                                           |
| string/richtext           | boolean/checkbox          | All objects gets `false` value                               |
| string/richtext           | string/select             | Data are preserved                                           |
| string/richtext           | array/object              | All object gets empty array                                  |
| string/richtext           | array/datasource          | All object gets empty array                                  |
| string/richtext           | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| string/email              | string/text               | Data are preserved                                           |
| string/email              | string/textarea           | Data are preserved                                           |
| string/email              | string/markdown           | Data are preserved                                           |
| string/email              | string/richtext           | Data are preserved                                           |
| string/email              | number/number             | All objects gets `0` value                                   |
| string/email              | string/radio              | Data are preserved                                           |
| string/email              | boolean/checkbox          | All objects gets `false` value                               |
| string/email              | string/select             | Data are preserved                                           |
| string/email              | array/object              | All object gets empty array                                  |
| string/email              | array/datasource          | All object gets empty array                                  |
| string/email              | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| number/number             | string/text               | Numbers are converted to string counterparts                 |
| number/number             | string/textarea           | Numbers are converted to string counterparts                 |
| number/number             | string/markdown           | Numbers are converted to string counterparts                 |
| number/number             | string/richtext           | Numbers are converted to string counterparts                 |
| number/number             | string/email              | Numbers are converted to string counterparts                 |
| number/number             | string/radio              | Numbers are converted to string counterparts                 |
| number/number             | boolean/checkbox          | All objects gets `false` value                               |
| number/number             | string/select             | Numbers are converted to string counterparts                 |
| number/number             | array/object              | All object gets empty array                                  |
| number/number             | array/datasource          | All object gets empty array                                  |
| number/number             | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| string/radio              | string/text               | Data are preserved                                           |
| string/radio              | string/textarea           | Data are preserved                                           |
| string/radio              | string/markdown           | Data are preserved                                           |
| string/radio              | string/richtext           | Data are preserved                                           |
| string/radio              | string/email              | Data are preserved                                           |
| string/radio              | number/number             | All objects gets `0` value                                   |
| string/radio              | boolean/checkbox          | All objects gets `false` value                               |
| string/radio              | string/select             | Data are preserved                                           |
| string/radio              | array/object              | All object gets empty array                                  |
| string/radio              | array/datasource          | All object gets empty array                                  |
| string/radio              | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| boolean/checkbox          | string/text               | Data are converted to the string counterparts                |
| boolean/checkbox          | string/textarea           | Data are converted to the string counterparts                |
| boolean/checkbox          | string/markdown           | Data are converted to the string counterparts                |
| boolean/checkbox          | string/richtext           | Data are converted to the string counterparts                |
| boolean/checkbox          | string/email              | Data are converted to the string counterparts                |
| boolean/checkbox          | number/number             | All objects gets `0` value                                   |
| boolean/checkbox          | string/radio              | Data are converted to the string counterparts                |
| boolean/checkbox          | string/select             | Data are converted to the string counterparts                |
| boolean/checkbox          | array/object              | All object gets empty array                                  |
| boolean/checkbox          | array/datasource          | All object gets empty array                                  |
| boolean/checkbox          | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| string/select             | string/text               | Data are preserved                                           |
| string/select             | string/textarea           | Data are preserved                                           |
| string/select             | string/markdown           | Data are preserved                                           |
| string/select             | string/richtext           | Data are preserved                                           |
| string/select             | string/email              | Data are preserved                                           |
| string/select             | number/number             | All objects gets `0` value                                   |
| string/select             | string/radio              | Data are preserved                                           |
| string/select             | boolean/checkbox          | All objects gets `false` value                               |
| string/select             | array/object              | All object gets empty array                                  |
| string/select             | array/datasource          | All object gets empty array                                  |
| string/select             | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| array/object              | string/text               | All objects gets `''` value                                  |
| array/object              | string/textarea           | All objects gets `''` value                                  |
| array/object              | string/markdown           | All objects gets `''` value                                  |
| array/object              | string/richtext           | All objects gets `''` value                                  |
| array/object              | string/email              | All objects gets `''` value                                  |
| array/object              | number/number             | All objects gets `0` value                                   |
| array/object              | string/radio              | All objects gets `''` value                                  |
| array/object              | boolean/checkbox          | All objects gets `false` value                               |
| array/object              | string/select             | All objects gets `''` value                                  |
| array/object              | array/datasource          | All object gets empty array                                  |
| array/object              | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| array/datasource          | string/text               | Data are converted to dataUrls joined with `', '`            |
| array/datasource          | string/textarea           | Data are converted to dataUrls joined with `', '`            |
| array/datasource          | string/markdown           | Data are converted to dataUrls joined with `', '`            |
| array/datasource          | string/richtext           | Data are converted to dataUrls joined with `', '`            |
| array/datasource          | string/email              | Data are converted to dataUrls joined with `', '`            |
| array/datasource          | number/number             | All objects gets `0` value                                   |
| array/datasource          | string/radio              | Data are converted to dataUrls joined with `', '`            |
| array/datasource          | boolean/checkbox          | All objects gets `false` value                               |
| array/datasource          | string/select             | Data are converted to dataUrls joined with `', '`            |
| array/datasource          | array/object              | All object gets empty array                                  |
| array/datasource          | object/geo                | All object gets object with value: `{lat: 0, lon: 0}`        |
| object/geo                | string/text               | Data are converted to `'lat: {lat value}, lon: {lon value}'` |
| object/geo                | string/textarea           | Data are converted to `'lat: {lat value}, lon: {lon value}'` |
| object/geo                | string/markdown           | Data are converted to `'lat: {lat value}, lon: {lon value}'` |
| object/geo                | string/richtext           | Data are converted to `'lat: {lat value}, lon: {lon value}'` |
| object/geo                | string/email              | Data are converted to `'lat: {lat value}, lon: {lon value}'` |
| object/geo                | number/number             | All objects gets `0` value                                   |
| object/geo                | string/radio              | Data are converted to `'lat: {lat value}, lon: {lon value}'` |
| object/geo                | boolean/checkbox          | All objects gets `false` value                               |
| object/geo                | string/select             | Data are converted to `'lat: {lat value}, lon: {lon value}'` |
| object/geo                | array/object              | All object gets empty array                                  |
| object/geo                | array/datasource          | All object gets empty array                                  |

## Updating Content Types through the Content modeller

If you'd rather use our graphical interface to update your Content Types - read the [Content modeller documentation](/docs/panel/content-types/)

[Register to send all requests with your own API today](https://editor.flotiq.com/register.html){: .flotiq-button}
