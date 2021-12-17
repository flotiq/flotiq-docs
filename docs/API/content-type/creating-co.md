title: How to add Content Objects | Flotiq docs
description: How to add Content Objects in Flotiq

# Content Objects :fontawesome-solid-exclamation-triangle:{ .pricing-info title="Limits apply" }[^1]

Once a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> 
has been defined in the system - the user can create 
<abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr>  of that Content Type. 
This is done either directly through the API or via the convenient Content Entry tools provided within the 
Content Management Platform.

!!! note
    You will need to use your `Application Read and write API KEY` to perform this action
    or `User API KEY` scoped to accept create on the Content Type you wish to add.
    Read more about [API keys and scoped API keys](/docs/API/).

## Creating Content Objects through the API

For a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> 
defined according to the [create Content Type example](/docs/API/content-type/creating-ctd), a very simple `POST` payload can be sent 
to the supporting endpoint `https://api.flotiq.com/api/v1/content/{name}` 
(where `name` is the name of the content type definition) to create a new Content Object:

```
{
  "title": "New object",
  "postContent": "This will be the new <b>content</b>"
}
```

!!! note
    You can send custom `id` in the object data to assign a particular `id` to the object.
    Random `id` will be assigned when the `id` property is not present in the object.

!!! Example

    === "CURL"

        ```
        curl --location --request POST 'https://api.flotiq.com/api/v1/content/blogposts' \
        --header 'X-AUTH-TOKEN: YOUR_API_KEY' \
        --header 'Content-Type: application/json' \
        --header 'Accept: */*' \
        --data-raw '{
            "title": "New object",
            "postContent": "This will be the new <b>content</b>"
        }'
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogposts");
        var request = new RestRequest(Method.POST);
        request.AddHeader("content-type", "application/json");
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        request.AddParameter("application/json", "{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}", ParameterType.RequestBody);
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
        
            url := "https://api.flotiq.com/api/v1/content/blogposts"
        
            payload := strings.NewReader("{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}")
        
            req, _ := http.NewRequest("POST", url, payload)
        
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
        RequestBody body = RequestBody.create(mediaType, "{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}");
        Request request = new Request.Builder()
        .url("https://api.flotiq.com/api/v1/content/blogposts")
        .post(body)
        .addHeader("content-type", "application/json")
        .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
        .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.post("https://api.flotiq.com/api/v1/content/blogposts")
            .header("content-type", "application/json")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .body("{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}")
            .asString();
        ```

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'POST',
            url: 'https://api.flotiq.com/api/v1/content/blogposts',
            headers: {'content-type': 'application/json', 'X-AUTH-TOKEN': 'YOUR_API_KEY'},
            body: {title: 'New object', postContent: 'This will be the new <b>content</b>'},
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
        CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "POST",
        CURLOPT_POSTFIELDS => "{\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}",
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
            "title": "New object",
            "postContent": "This will be the new <b>content</b>"
        }
        ```

    === "400 Validation error"

        Returned when data has not been correct, and the object was not saved

        ```
        {
            "id": [
                "This value is already used",
                "Must be at least 1 characters long",
            ],
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

| Error                                                                                    | Description                                                                                                 |
| ---------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| This value is already used                                                               | Send when the property has to be unique, and the value is already used in an existing object of that type   |
| Must be at least 1 characters long                                                       | Send when the property is required, and an empty string was sent in object                                  |
| The property \{name\} is required                                                        | Send when the property is required and was missing in the sent object                                       |
| String value found, but a number is required                                             | Send when the type of the property is `number` and string was sent                                          |
| The value does not match possible options                                                | Send when sent value do not match options in `select` and `radio` type                                      |
| Does not match the regex pattern \{pattern\}                                             | Send when the value does not match regex pattern specified for the property                                 |
| This value does not exist in database                                                    | Send when object attached in relation or media array does not exist in the database                         |
| One of the block types (\{block type\} on index \{index\}) does not match possible types | Send when one of the types in the property of the type `block` does not match types specified in the schema |


### Creating Content Objects with relations to other types or media

To add objects with relations, you need to know ids and types of related objects. 
Relations are always an array, even if only one relation object is allowed. 
Order of relation object is preserved. 
Every relation object have to have `type` property (now only `internal` is possible), 
and `dataUrl` property containing relative url to the object (`/api/v1/content/{type}/{id}`).

!!! Example

    === "Relation to `test` content type object"
        
        ```
        "relation": [
            {
              "dataUrl": "/api/v1/content/test/test-1",
              "type": "internal"
            }
        ]
        ```

    === "Multiple relation to media objects"
        
        ```
        "media": [
            {
              "dataUrl": "/api/v1/content/_media/_media-1",
              "type": "internal"
            },
            {
              "dataUrl": "/api/v1/content/_media/_media-2",
              "type": "internal"
            }
        ]
        ```        

### Creating Content Objects with the editor.js blocks

Blocks contain json definitions of the html blocks instead of the real html blocks
to make sure that the data will be displayed correctly in every environment
(developer can manage them correctly in the standard React and React Native for example).

Block parameters:

| Parameter | Required | Description                                                                                                                                                                  |
| --------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| id        | true     | Random identifier of the block                                                                                                                                               |
| data      | true     | Data of the block, the parameters depend on the type of the block                                                                                                            |
| type      | true     | Type of the block, the supported types are `paragraph`, `header`, `list`, `image`, `youtubeEmbed`, `quote`, `warning`, `code`, `table` and `delimiter`, types can be narrowed down in schema |
| tunes     | false    | Additional settings of the block, parameters depend on the type of the block                                                                                                 |

Blocks:

??? Paragraph

    === "Description"

        Contains standard text with limited text formatting (bolding, italicizing, alignment). Type: `paragraph`.
        
        Data parameters:
        
        | Parameter | Required | Description                                                                                                    |
        | --------- | -------- | -------------------------------------------------------------------------------------------------------------- |
        | text      | true     | Content of the paragraph, it can contain html formatting (`<b></b>` for bolding and `<i></i>` for italicizing) |
        
        Tunes parameters: 
        
        | Parameter         | Required | Description                                              |
        | ----------------- | -------- | -------------------------------------------------------- |
        | alignmentTuneTool | true     | Information obout text alignment in the whole paragraph. |
        
        alignmentTuneTool parameters:
        
        | Parameter | Required | Description                                                                                         |
        | --------- | -------- | --------------------------------------------------------------------------------------------------- |
        | alignment | true     | Information about text alignment in the whole paragraph. Possible values: `left`, `center`, `right` |

    === "Example"

        ```
        {
            "id": "i5RZbGlOWy",
            "data": {
                "text": "<b>Exaple</b> <i>paragraph </i>with formatting"
            },
            "type": "paragraph",
            "tunes": {
                "alignmentTuneTool": {
                    "alignment": "left"
                }
            }
        }
        ```

??? Header

    === "Description"
        Contains standard header text with limited text formatting (bolding, italicizing, alignment). Type: `header`.
        
        Data parameters:
        
        | Parameter | Required | Description                                                                                                 |
        | --------- | -------- | ----------------------------------------------------------------------------------------------------------- |
        | text      | true     | Content of the header, it can contain html formatting (`<b></b>` for bolding and `<i></i>` for italicizing) |
        | level     | true     | Level of the header. Possible values `1`, `2`, `3`, `4`, `5`, `6`.                                          |
        | anchor    | false    | Name of the navigation anchor fo the header                                                                 |
        
        Tunes parameters:
        
        | Parameter         | Required | Description                                              |
        | ----------------- | -------- | -------------------------------------------------------- |
        | alignmentTuneTool | true     | Information obout text alignment in the whole header.    |
        
        alignmentTuneTool parameters:
        
        | Parameter | Required | Description                                                                                         |
        | --------- | -------- | --------------------------------------------------------------------------------------------------- |
        | alignment | true     | Information about text alignment in the whole header. Possible values: `left`, `center`, `right`    |


    === "Example"
        ```
        {
            "id": "dPSax4QzPU",
            "data": {
                "text": "Example level 2 header",
                "level": 2,
                "anchor": "anchor"
            },
            "type": "header",
            "tunes": {
                "alignmentTuneTool": {
                    "alignment": "center"
                }
            }
        }
        ```

??? List

    === "Description"
        Contains nested lists with limited text formatting (bolding, italicizing). Type: `list`.
        
        Data parameters:
        
        | Parameter | Required | Description                                                |
        | --------- | -------- | ---------------------------------------------------------- |
        | items     | true     | Items of the list                                          |
        | style     | true     | Style of the list. Possible values `ordered`, `unordered`. |
        
        
        Items parameters:
        
        | Parameter | Required | Description                                                                                                  |
        | --------- | -------- | ------------------------------------------------------------------------------------------------------------ |
        | items     | true     | Items of the sublist                                                                                         |
        | content   | true     | Text of the liust item, it can contain html formatting (`<b></b>` for bolding and `<i></i>` for italicizing) |

    === "Example"
        ```
        {
            "id": "oCJRGb2FFb",
            "data": {
                "items": [
                    {
                        "items": [
                            {
                                "items": [],
                                "content": "Example <i>list</i>"
                            }
                        ],
                        "content": "Exaple list"
                    }
                ],
                "style": "ordered"
            },
            "type": "list"
        }
        ```

??? Image

    === "Description"
        Contains image from Flotiq Media Library. Type: `image`.
        
        Data parameters:
        
        | Parameter      | Required | Description                                                             |
        | -------------- | -------- | ----------------------------------------------------------------------- |
        | url            | true     | Url to full size file                                                   |
        | width          | true     | Width of the image                                                      |
        | height         | true     | Height of the image                                                     |
        | fileName       | true     | Name of the file                                                        |
        | extension      | true     | File extension                                                          |
        | caption        | true     | File caption                                                            |
        | stretched      | true     | Information whether the image should be stretched to full display width |
        | withBorder     | true     | Information whether the image should have border                        |
        | withBackground | true     | Information whether the image should have background                    |

    === "Example"
        ```
        {
            "id": "zX1gTCKJee",
            "data": {
                "url": "https://api.flotiq.com/image/0x0/_media-1bb7c3ad-53de-4029-a5a0-3500f9b8867e.png",
                "width": 317,
                "height": 265,
                "caption": "Example Caption",
                "fileName": "example.png",
                "extension": "png",
                "stretched": true,
                "withBorder": true,
                "withBackground": true
            },
            "type": "image"
        }
        ```

??? YouTube embed

    === "Description"
        Contains link to YouTube video. Type: `youtubeEmbed`.
        
        Data parameters:
        
        | Parameter | Required | Description        |
        | --------- | -------- | ------------------ |
        | url       | true     | YouTube video link |

    === "Example"
        ```
        {
            "id": "JIRwiQdzs9",
            "data": {
                "url": "https://www.youtube.com/watch?v=hz3RK5qqhrQ"
            },
            "type": "youtubeEmbed"
        }
        ```

??? "Quote"

    === "Description"
        Contains the quote with the caption. Type: `quote`.
        
        Data parameters:
        
        | Parameter | Required | Description                                               |
        | --------- | -------- | --------------------------------------------------------- |
        | text      | true     | Text of the quote                                         |
        | caption   | true     | Caption of the quote                                      |
        | text      | true     | Alignment of the quote. Possible values: `left`, `center` |


    === "Example"
        ```
        {
            "id": "V7WlZmeTuJ",
            "data": {
                "text": "Example quote",
                "caption": "Example quote caption",
                "alignment": "left"
            },
            "type": "quote"
        }
        ```

??? "Warning"

    === "Description"
        Contains the warning with the name. Type: `warning`.
        
        Data parameters:
        
        | Parameter | Required | Description          |
        | --------- | -------- | -------------------- |
        | message   | true     | Text of the warning  |
        | title     | true     | Title of the warning |

    === "Example"
        ```
        {
            "id": "sVDwJq9ZCe",
            "data": {
                "title": "Exaple warning name",
                "message": "Example warning message"
            },
            "type": "warning"
        }
        ```

??? Delimiter

    === "Description"
        Contains the information that displaying application should display delimiter, without other fomatting.
        Type: `delimiter`.

        Data have to be empty object.

    === "Example"
        ```
        {
            "id": "dPSax4QzPU",
            "data": {},
            "type": "delimiter"
        }
        ```

??? "Code"

    === "Description"
        Contains the code block. Type: `code`.
        
        Data parameters:
        
        | Parameter | Required | Description          |
        | --------- | -------- | -------------------- |
        | code      | true     | Code block  |

    === "Example"
        ```
        {
            "id": "sVDwJq9ZCf",
            "data": {
                "code": "npm run dev",
            },
            "type": "code"
        }
        ```

??? "Table"

    === "Description"
        Contains the table. Type: `table`.
        
        Data parameters:
        
        | Parameter | Required | Description          |
        | --------- | -------- | -------------------- |
        | content   | true     | Array of arrays of data in rows, every row is an array of srings   |
        | withHeadings   | true     | Information if the first row should be treated as header |

    === "Example"
        ```
        {
            "id": "sVDwJq9ZCg",
            "data": {
                "content": [
                    [
                        "First header",
                        "Second header",
                        "Third header"
                    ],
                    [
                        "First column of the first row",
                        "Second column of the first row",
                        "Third column of the first row"
                    ],
                    [
                        "First column of the second row",
                        "Second column of the second row",
                        "Third column of the second row"
                    ]
                ],
                "withHeadings": true
            },
            "type": "table"
        }
        ```

If we are missing a block type or tune that you require for your project,
please leave a comment below or contact us on [hello@flotiq.com](mailto:hello@flotiq.com).

??? "Example of an object containing all property types"

    This example represents object for Content Type with every type of property,
    described [here](/API/content-type/creating-ctd/#example-with-every-type-of-field)

    ```
    {
      "id": "example-1",
      "geo": {
        "lat": 0,
        "lon": 0
      },
      "date": "2021-12-12T12:00",
      "list": [
        {
          "geo_in_subobject": {
            "lat": 0,
            "lon": 0
          },
          "date_in_subobject": "2021-12-12T12:00",
          "text_in_subobject": "text_in_subobject",
          "block_in_subobject": {
            "time": "1624628260",
            "version": "2.22.0",
            "blocks": [
              {
                "id": "dPSax4QzPU",
                "data": {
                  "text": "Example level 2 header",
                  "level": 2,
                  "anchor": "anchor"
                },
                "type": "header",
                "tunes": {
                  "alignmentTuneTool": {
                    "alignment": "center"
                  }
                }
              },
              {
                "id": "i5RZbGlOWy",
                "data": {
                  "text": "<b>Exaple</b> <i>paragraph </i>with formatting"
                },
                "type": "paragraph",
                "tunes": {
                  "alignmentTuneTool": {
                    "alignment": "left"
                  }
                }
              },
              {
                "id": "oCJRGb2FFb",
                "data": {
                  "items": [
                    {
                      "items": [
                        {
                          "items": [],
                          "content": "Example <i>list</i>"
                        }
                      ],
                      "content": "Exaple list"
                    }
                  ],
                  "style": "ordered"
                },
                "type": "list"
              },
              {
                "id": "XB_EtsgceZ",
                "data": {
                  "items": [
                    {
                      "items": [
                        {
                          "items": [],
                          "content": "Example bullet list"
                        }
                      ],
                      "content": "Example bullet <b>list</b>"
                    }
                  ],
                  "style": "unordered"
                },
                "type": "list"
              },
              {
                "id": "zX1gTCKJee",
                "data": {
                  "url": "https://api.flotiq.com/image/0x0/_media-1bb7c3ad-53de-4029-a5a0-3500f9b8867e.png",
                  "width": 317,
                  "height": 265,
                  "caption": "Example Caption",
                  "fileName": "example.png",
                  "extension": "png",
                  "stretched": true,
                  "withBorder": true,
                  "withBackground": true
                },
                "type": "image"
              },
              {
                "id": "JIRwiQdzs9",
                "data": {
                  "url": "https://www.youtube.com/watch?v=hz3RK5qqhrQ"
                },
                "type": "youtubeEmbed"
              },
              {
                "id": "V7WlZmeTuJ",
                "data": {
                  "text": "Example quote",
                  "caption": "Example quote caption",
                  "alignment": "left"
                },
                "type": "quote"
              },
              {
                "id": "sVDwJq9ZCe",
                "data": {
                  "title": "Exaple warning name",
                  "message": "Example warning message"
                },
                "type": "warning"
              },
              {
                "id": "RTJ0lo2VGB",
                "data": [],
                "type": "delimiter"
              },
              {
                "id": "sVDwJq9ZCf",
                "data": {
                  "code": "npm run dev",
                },
                "type": "code"
              },
              {
                "id": "sVDwJq9ZCg",
                "data": {
                  "content": [
                    [
                      "First header",
                      "Second header",
                      "Third header"
                    ],
                    [
                      "First column of the first row",
                      "Second column of the first row",
                      "Third column of the first row"
                    ],
                    [
                      "First column of the second row",
                      "Second column of the second row",
                      "Third column of the second row"
                    ]
                  ],
                  "withHeadings": true
                },
                "type": "table"
              }
            ]
          },
          "emain_in_subobject": "emain_in_subobject",
          "media_in_subobject": [
            {
              "dataUrl": "/api/v1/content/_media/_media-1",
              "type": "internal"
            }
          ],
          "radio_in_subobject": "radio_in_subobject",
          "number_in_subobject": 0,
          "select_in_subobject": "Option a",
          "checkbox_in_subobject": false,
          "markdown_in_subobject": "markdown_in_subobject",
          "relation_in_subobject": [
            {
              "dataUrl": "/api/v1/content/test/test-1",
              "type": "internal"
            }
          ],
          "textarea_in_subobject": "textarea_in_subobject",
          "rich_text_in_subobject": "rich_text_in_subobject"
        }
      ],
      "text": "text",
      "block": {
        "time": "1624628260",
        "version": "2.22.0",
        "blocks": [
          {
            "id": "dPSax4QzPU",
            "data": {
              "text": "Example level 2 header",
              "level": 2,
              "anchor": "anchor"
            },
            "type": "header",
            "tunes": {
              "alignmentTuneTool": {
                "alignment": "center"
              }
            }
          },
          {
            "id": "i5RZbGlOWy",
            "data": {
              "text": "<b>Exaple</b> <i>paragraph </i>with formatting"
            },
            "type": "paragraph",
            "tunes": {
              "alignmentTuneTool": {
                "alignment": "left"
              }
            }
          },
          {
            "id": "oCJRGb2FFb",
            "data": {
              "items": [
                {
                  "items": [
                    {
                      "items": [],
                      "content": "Example <i>list</i>"
                    }
                  ],
                  "content": "Exaple list"
                }
              ],
              "style": "ordered"
            },
            "type": "list"
          },
          {
            "id": "XB_EtsgceZ",
            "data": {
              "items": [
                {
                  "items": [
                    {
                      "items": [],
                      "content": "Example bullet list"
                    }
                  ],
                  "content": "Example bullet <b>list</b>"
                }
              ],
              "style": "unordered"
            },
            "type": "list"
          },
          {
            "id": "zX1gTCKJee",
            "data": {
              "url": "https://api.flotiq.com/image/0x0/_media-1bb7c3ad-53de-4029-a5a0-3500f9b8867e.png",
              "width": 317,
              "height": 265,
              "caption": "Example Caption",
              "fileName": "example.png",
              "extension": "png",
              "stretched": true,
              "withBorder": true,
              "withBackground": true
            },
            "type": "image"
          },
          {
            "id": "JIRwiQdzs9",
            "data": {
              "url": "https://www.youtube.com/watch?v=hz3RK5qqhrQ"
            },
            "type": "youtubeEmbed"
          },
          {
            "id": "V7WlZmeTuJ",
            "data": {
              "text": "Example quote",
              "caption": "Example quote caption",
              "alignment": "left"
            },
            "type": "quote"
          },
          {
            "id": "sVDwJq9ZCe",
            "data": {
              "title": "Exaple warning name",
              "message": "Example warning message"
            },
            "type": "warning"
          },
          {
            "id": "RTJ0lo2VGB",
            "data": [],
            "type": "delimiter"
          },
          {
            "id": "sVDwJq9ZCf",
            "data": {
              "code": "npm run dev",
            },
            "type": "code"
          },
          {
            "id": "sVDwJq9ZCg",
            "data": {
              "content": [
                [
                  "First header",
                  "Second header",
                  "Third header"
                ],
                [
                  "First column of the first row",
                  "Second column of the first row",
                  "Third column of the first row"
                ],
                [
                  "First column of the second row",
                  "Second column of the second row",
                  "Third column of the second row"
                ]
              ],
              "withHeadings": true
            },
            "type": "table"
          }
        ]
      },
      "email": "email",
      "media": [
        {
          "dataUrl": "/api/v1/content/_media/_media-1",
          "type": "internal"
        }
      ],
      "radio": "Option 1",
      "number": 0,
      "select": "Option 1",
      "checkbox": false,
      "markdown": "markdown",
      "relation": [
        {
          "dataUrl": "/api/v1/content/test/test-1",
          "type": "internal"
        }
      ],
      "textarea": "textarea",
      "rich_text": "rich_text"
    }
    ```


## Batch create Content Objects through API

There is a way to add up to 100 Content Objects at once. 
It is possible by using the `/batch` endpoint 
(in our example, the URL would be `https://api.flotiq.com/api/v1/content/blogposts/batch`). 
It can be only `insert` or `insert or update` operation. To use `insert or update` 
you need to set `updateExisting` to `true` in the query. 

All objects must meet the same conditions as when adding a single object. 
The only difference is an array of objects in the request body instead of one object.

!!! note
    In the next examples we assume that we have an object with id `existing-id-1` in our system.

Updating one blog post and adding one new:

!!! Example

    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"existing-id-1","title":"Updated object","postContent":"This will be the updated <b>content</b>"},{"id":"new-object-1","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 200):
    ```
    {
        "batch_total_count": 2,
        "batch_success_count": 2,
        "batch_error_count": 0,
        "errors": []
    }
    ```

Trying updating one blog post and adding one new with wrong data:

!!! Example

    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"existing-id-1","title":"Updated object"},{"id":"new-object-2","title":"New object 3","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 400):
    ```
    {
        "batch_total_count": 2,
        "batch_success_count": 1,
        "batch_error_count": 1,
        "errors": [
          {
            "id": "existing-id-1",
            "errors": {
              "postContent": [
                "The property postContent is required"
              ]
            }
          }
        ]
    }
    ```

Trying updating one blog post and adding one new with duplicated id:

!!! Example

    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"example-id-1","title":"New object","content": "This will be the new <b>content</b>"},{"id":"example-id-1","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 400):
    ```
    {
      "data": [
        "There are duplications in object data, key: id"
      ]
    }
    ```

Response parameters:

| Parameter           | Description                                                                                                                                            |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| batch_total_count   | number of elements sent in the request, present when there are no duplications in data                                                                 |
| batch_success_count | number of correct elements sent in the request, present when there are no duplications in data                                                         |
| batch_error_count   | number of incorrect elements sent in the request, present when there are no duplications in data                                                       |
| errors              | array of errors in the elements, errors are objects containing the id of the object and list of errors, present when there are no duplications in data |
| data                | present only when there are duplications in data, listing keys containing duplications (see example above)                                             |

[Register to start creating your content objects](https://editor.flotiq.com/register.html){: .flotiq-button}


[^1]: Number of available Content Objects depends on the chosen subscription plan. Check pricing and limits [here](https://flotiq.com/pricing){:target="_blank"}
