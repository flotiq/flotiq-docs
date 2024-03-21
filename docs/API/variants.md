title: Media transformations | Flotiq docs
description: How to transform an image in Flotiq

# Overview

This document describes the functionality of variants and transformations for `_media` content type definition and images in the Flotiq. It outlines the structure of variants, acceptable transformation types, endpoints for variant operations, and considerations for using variants effectively.

# Media Variants

A variant refers to an altered version of an original media asset. Variants are created by applying transformations to the original media, such as cropping, resizing, or other image manipulations. These transformations are defined within the variant object in the _media content type definition (CTD) schema.

For example, a variant named "thumbnail" might be created by applying a transformation to resize the original image to a smaller size suitable for use as a thumbnail. Another variant named "cropped" might be created by applying a transformation to crop the original image to a specific aspect ratio.

Variants allow for the efficient management of media assets by providing different versions optimized for various use cases, such as different screen sizes or aspect ratios, allowing the developer to dynamically serve the most appropriate version of the media based on the requirements of the application or webpage.

## Variants Schema

Each variant consists of:

- A name: A unique identifier for the variant.
- Transformation type(s): Describes the type of transformation(s) applied to the original media, such as trimming, resizing, etc.
- Transformation parameters: Specifies the details of the transformation(s), such as the amount to trim from each side of the dimensions to resize the image.

The schema allows for the addition of variants with transformations. A variant object contains the following properties:

```
"variants": [
    {
        "name": "<variantName>",
        "<transformation type>": {
            "<key>": <value>,
            "<key>": <value>
        }
    }
]
```
{ data-search-exclude }

Note that the `variants` key above is an optional key inside of the object of type `_media`.

!!! Example

    ```
    {
        "name": "thumbnail",
        "trim": {
            "top": 10,
            "right": 10,
            "width":200,
            "height":200
        }
    }
    ```
    { data-search-exclude }

!!! Note
    - Media objects without any variants initially won't have the "variants" key in their object data. It will be automatically added when the first variant for that media is created.
    - Removing all variants of an asset won't delete the "variants" key from object data.
    - Variant names must be unique and follow the regex pattern: `^[_a-z]+$` (case insensitive).

## Transformation Types

Currently, the only acceptable type of transformation is `trim`.
<!-- The transformations follow Cloudflare's transformation standards. -->
<!-- https://developers.cloudflare.com/images/transform-images/transform-via-workers -->

Trim accepts 4 properties in two possible combinations:

- `top,right,bottom,left` - defines how many pixels should be trimmed from each side of the image.

!!! Example
    For variant:

    ```
    {
        "name":"thumbnail",
        "trim": {
            "top":10,
            "right":10,
            "bottom":10,
            "left":10
        }
    }
    ```
    { data-search-exclude }

    If the original image is 400/400, it will be cropped to 380/380, cutting 10 pixels from each side.

- `top,left,width,height` - defines the top left point of the crop, and number of pixels that will be cropped into the resulting image.

!!! Example
    For variant:

    ```
    {
        "name":"thumbnail",
        "trim": {
            "top":10,
            "left":10,
            "width":50,
            "height":50
        }
    }
    ```
    { data-search-exclude }

    If the original image is 400/400, it will result in cropping a 50/50 square in the top left corner, 10 pixels away from the top/left side.

!!! Note
    Transforming works together with resizing (width/height properties used in every GET image endpoint). Note that images are transformed before they are resized.

## Handling Variants

Creating, removing and updating variants can be done in two ways, either by updating the media content object itself using standard endpoints for editing the content object's data or by using designated endpoints for operations on variants.

Handling variants through editing media content object directly may be faster and more flexible, considering you can provide any value for the `variants` key, like adding multiple variants at once etc., as long as the schema for those variants gets properly validated with the variants schema presented above.

Using designated endpoints for variants is more straightforward and faster if you are not planning on creating significantly complex operations on objects.

!!! Note
    Endpoints for creating and removing variants require **update** permissions on objects of `_media` content type.

### Create a New Variant

The endpoint for creating variants accepts a single variant object and adds it into the `variants` array key of `_media` content object.
In order to use the endpoint, send a PUT request to `https://api.flotiq.com/api/media/{your-image-id}/variant` where `{your-image-id}` is the id of the image that you are creating variant for.

!!! Example

    === "Curl"
        ```
        curl -X PUT \
            -H "Content-Type: application/json" \
            -H "X-AUTH-TOKEN: YOUR_API_KEY" \
            -d '{"name": "thumbnail", "trim": {"top": 10, "right": 10, "bottom": 10, "left": 10, "width": 200, "height": 200}}' \
            https://api.flotiq.com/api/media/your-image-id/variant
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/media/your-image-id/variant");
        var request = new RestRequest(Method.PUT);
        request.AddHeader("Content-Type", "application/json");
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        request.AddParameter("application/json", "{\"name\": \"thumbnail\", \"trim\": {\"top\": 10, \"right\": 10, \"bottom\": 10, \"left\": 10, \"width\": 200, \"height\": 200}}", ParameterType.RequestBody);
        IRestResponse response = client.Execute(request);
        ```
        { data-search-exclude }

    === "Go + Native"

        ```
        package main

        import (
            "bytes"
            "fmt"
            "net/http"
        )

        func main() {
            url := "https://api.flotiq.com/api/media/your-image-id/variant"
            payload := []byte(`{"name": "thumbnail", "trim": {"top": 10, "right": 10, "bottom": 10, "left": 10, "width": 200, "height": 200}}`)

            req, err := http.NewRequest("PUT", url, bytes.NewBuffer(payload))
            if err != nil {
                panic(err)
            }
            req.Header.Set("Content-Type", "application/json")
            req.Header.Set("X-AUTH-TOKEN", "YOUR_API_KEY")

            client := &http.Client{}
            resp, err := client.Do(req)
            if err != nil {
                panic(err)
            }
            defer resp.Body.Close()

            fmt.Println("response Status:", resp.Status)
        }
        ```
        { data-search-exclude }

    === "Java + Okhttp"

        ```
        OkHttpClient client = new OkHttpClient();

        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, "{\"name\": \"thumbnail\", \"trim\": {\"top\": 10, \"right\": 10, \"bottom\": 10, \"left\": 10, \"width\": 200, \"height\": 200}}");
        Request request = new Request.Builder()
          .url("https://api.flotiq.com/api/media/your-image-id/variant")
          .put(body)
          .addHeader("Content-Type", "application/json")
          .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
          .build();

        Response response = client.newCall(request).execute();
        System.out.println(response.body().string());
        ```
        { data-search-exclude }

    === "Java + Unirest"

        ```
        HttpResponse<String> response = Unirest.put("https://api.flotiq.com/api/media/your-image-id/variant")
            .header("Content-Type", "application/json")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .body("{\"name\": \"thumbnail\", \"trim\": {\"top\": 10, \"right\": 10, \"bottom\": 10, \"left\": 10, \"width\": 200, \"height\": 200}}")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"

        ```
        const request = require('request');
        let body = {
            "name": "thumbnail",
            "trim": {
                "top": 10,
                "right": 10,
                "bottom": 10,
                "left": 10,
                "width":200,
                "height":200
            }
        }
        const options = {
            method: 'PUT',
            url: 'https://api.flotiq.com/api/media/your-image-id/variant',
            headers: {'content-type': 'application/json', 'X-AUTH-TOKEN': 'YOUR_API_KEY'},
            body: body,
            json: true
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

        curl_setopt_array($curl, array(
        CURLOPT_URL => 'https://api.flotiq.com/api/media/your-image-id/variant',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'PUT',
        CURLOPT_POSTFIELDS => '{"name": "thumbnail", "trim": {"top": 10, "right": 10, "bottom": 10, "left": 10, "width": 200, "height": 200}}',
        CURLOPT_HTTPHEADER => array(
            'Content-Type: application/json',
            'X-AUTH-TOKEN: YOUR_API_KEY'
        ),
        ));

        $response = curl_exec($curl);

        curl_close($curl);
        echo $response;
        ?>
        ```
        { data-search-exclude }

!!! Responses

    === "200 OK"

        Returned when the variant was added

        ```
        {
            "id": "media-1",
            "url": "image/0x0/media-1.jpg",
            "size": 350682,
            "type": "image",
            "width": 1920,
            "height": 1200,
            "source": "disk",
            "fileName": "ExampleImage1.png",
            "internal": {...},
            "mimeType": "image/png",
            "extension": "png",
            "externalId": "",
            "variants": [
                {
                    "name": "thumbnail",
                    "trim": {
                        "top": 10,
                        "right": 10,
                        "bottom": 10,
                        "left": 10,
                        "width": 200,
                        "height": 200
                    }
                }
            ]
        }
        ```
        { data-search-exclude }

    === "400 Validation error"

        Returned when data has not been correct, and the variant was not added

        ```
        {
            "data": [
                "Variant must include property 'name'"
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

    === "403 Forbidden"

        Returned API key does not have permission to update _media objects
  
        ```
        {
            "code": 403,
            "massage": "Adding variant requires Content Object 'Media' update privilege"
        }
        ```
        { data-search-exclude }

    === "404 Not found"

        Returned when the `_media` content object wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```
        { data-search-exclude }

### Remove Variant

The endpoint for creating variants accepts a single variant object and adds it into the `variants` array key of `_media` content object.
In order to use the endpoint, send a PUT request to `https://api.flotiq.com/api/media/{your-image-id}/variant` where `{your-image-id}` is the id of the image that you are creating variant for.

In order to remove a variant from your content object, send a DELETE request to `https://api.flotiq.com/api/media/{your-image-id}/variant/{variant-name}` where:

- `{your-image-id}` - is the id of an image that you want to remove a variant from
- `{variant-name}` - is the name of the variant you want removed

!!! Example

    === "CURL" 

        ```
        curl -X DELETE \
            -H "X-AUTH-TOKEN: YOUR_API_KEY" \
            https://api.flotiq.com/api/media/your-image-id/variant/variant-name
        ``` 
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/media/your-image-id/variant/variant-name");
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
        )

        func main() {
            req, err := http.NewRequest("DELETE", "https://api.flotiq.com/api/media/your-image-id/variant/variant-name", nil)
            if err != nil {
                fmt.Println("Error:", err)
                return
            }
            req.Header.Set("X-AUTH-TOKEN", "YOUR_API_KEY")

            client := &http.Client{}
            resp, err := client.Do(req)
            if err != nil {
                fmt.Println("Error:", err)
                return
            }
            defer resp.Body.Close()

            fmt.Println("Response Status:", resp.Status)
        }
        ```
        { data-search-exclude }
    
    === "Java + Okhttp"
        
        ```
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
            .url("https://api.flotiq.com/api/media/your-image-id/variant/variant-name")
            .delete()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
          
        Response response = client.newCall(request).execute();
        System.out.println(response.body().string());
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest
            .delete("https://api.flotiq.com/api/media/your-image-id/variant/variant-name")
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
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, "https://api.flotiq.com/api/media/your-image-id/variant/variant-name");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'X-AUTH-TOKEN: YOUR_API_KEY'
        ]);

        $response = curl_exec($ch);
        echo $response;
        curl_close($ch);
        ?>
        ```
        { data-search-exclude }

!!! Responses

    === "204 OK"

        Returned when the variant was deleted

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

        Returned when the media content object or variant wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```
        { data-search-exclude }

### Get Variant

For fetching images transformed with properties defined in variants use GET `https://api.flotiq.com/image/{width}x{height}/{id}/{fileName}.{extension}/variant/{variant-name}` endpoint, which functions the same as a regular [endpoint for retrieving media](https://flotiq.com/docs/API/media-library/#getting-files), but additionally accepts variant name, which should contain the name of the variant that you have defined for this media object.

The resulting image will be formatted according to the variant's properties you have defined.

# Transforming images without creating variants

There are two options for fetching transformed images from your media library without the need for defining variants for corresponding objects of `_media` content type definition.

The first one is to use the standard endpoint for fetching images and adding `?transform` query parameter to it that contains the same object for transformation a variant would, excluding the `name` key, for example:

GET `https://api.flotiq.com/image/0x0/id/fileName.ext?transform={"trim":{"top":0,"right":50,"bottom":50,"left":50,"width":200,"height":200}}`

Another way of retrieving transformed assets from the media library without creating a variant is to use a designated endpoint for such transformations. To use this endpoint, send the GET request to `https://api.flotiq.com/image/{width}x{height}/{id}/{fileName}.{extension}/transform/{transformation-type}/{parameters}`

For trimming the image, you have to provide `trim` value for `transformation-type` path parameter, and the following parameters: top,right,width,height; separated with commas, for example:

GET `https://api.flotiq.com/image/0x0/id/fileName.ext/transform/trim/50,50,200,200`

# Conclusion

Flotiq allows for the creation, management, and retrieval of variants, offering practical examples and response handling. By following these guidelines, users can efficiently optimize and customize media assets for various use cases, enhancing application performance and flexibility. Overall, this documentation serves as a valuable resource for developers looking to leverage Flotiq's capabilities for media transformation.
