---
tags:
  - Developer
---

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
    - Variant names must be unique and follow the regex pattern: `^[_a-zA-Z0-9]+$` (case insensitive).

## Transformation Types

Currently, the only acceptable type of transformation is `trim`.

Trim accepts 4 properties in two possible combinations:

- `top,right,bottom,left` - defines how many pixels should be trimmed from each side of the image.

!!! Example
    For variant:

    ```
    {
        "name": "thumbnail",
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

- `top,left,width,height` - defines the top left point of the crop, and a number of pixels that will be cropped into the resulting image.

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

### Creating variants with API

Operations on variants via API are done by updating the content object of `_media` content type, which contains the URL to the media asset you wish to create a variant for. You can simply use an [endpoint for content update](https://flotiq.com/docs/API/content-type/updating-co/) for your media, and edit the `variants` array, adding new variant objects as its keys. Keep in mind, that the key `variants` in media object is optional, so you may have to add it first.

!!! Example

    === "CURL"

        ```
        curl --location --request PATCH 'https://api.flotiq.com/api/v1/content/_media/_media-ae09b475-2389-411a-8012-615d5ac85edb' \
        --header 'X-AUTH-TOKEN: YOUR_API_KEY' \
        --header 'Content-Type: application/json' \
        --header 'Accept: */*' \
        --data-raw '{
            "variants": [
                {
                    "name": "thumbnail_crop",
                    "trim": {
                        "top": 747,
                        "left": 316,
                        "width": 3944,
                        "height": 2958
                    }
                }
            ]
        }'
        ```
        { data-search-exclude }

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/_media/_media-ae09b475-2389-411a-8012-615d5ac85edb");
        var request = new RestRequest(Method.PATCH);
        request.AddHeader("content-type", "application/json");
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        request.AddParameter("application/json", "{\"variants\":[{\"name\":\"thumbnail_crop\",\"trim\":{\"top\":747,\"left\":316,\"width\":3944,\"height\":2958}}]}", ParameterType.RequestBody);
        IRestResponse response = client.Execute(request);
        ```
        { data-search-exclude }
    
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
        
            url := "https://api.flotiq.com/api/v1/content/_media/_media-ae09b475-2389-411a-8012-615d5ac85edb"
        
            payload := strings.NewReader("{\"variants\":[{\"name\":\"thumbnail_crop\",\"trim\":{\"top\":747,\"left\":316,\"width\":3944,\"height\":2958}}]}")
        
            req, _ := http.NewRequest("PATCH", url, payload)
        
            req.Header.Add("content-type", "application/json")
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

        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, "{\"variants\":[{\"name\":\"thumbnail_crop\",\"trim\":{\"top\":747,\"left\":316,\"width\":3944,\"height\":2958}}]}");
        Request request = new Request.Builder()
        .url("https://api.flotiq.com/api/v1/content/_media/_media-ae09b475-2389-411a-8012-615d5ac85edb")
        .patch(body)
        .addHeader("content-type", "application/json")
        .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
        .build();
        
        Response response = client.newCall(request).execute();
        ```
        { data-search-exclude }

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.patch("https://api.flotiq.com/api/v1/content/_media/_media-ae09b475-2389-411a-8012-615d5ac85edb")
            .header("content-type", "application/json")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .body("{\"variants\":[{\"name\":\"thumbnail_crop\",\"trim\":{\"top\":747,\"left\":316,\"width\":3944,\"height\":2958}}]}")
            .asString();
        ```
        { data-search-exclude }

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'PATCH',
            url: 'https://api.flotiq.com/api/v1/content/_media/_media-ae09b475-2389-411a-8012-615d5ac85edb',
            headers: {'content-type': 'application/json', 'X-AUTH-TOKEN': 'YOUR_API_KEY'},
            body: {variants: [{name: 'thumbnail_crop', trim: {top: 747, left: 316, width: 3944, height: 2958}}]},
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
        
        curl_setopt_array($curl, [
        CURLOPT_URL => "https://api.flotiq.com/api/v1/content/_media/_media-ae09b475-2389-411a-8012-615d5ac85edb",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "PATCH",
        CURLOPT_POSTFIELDS => "{\"variants\":[{\"name\":\"thumbnail_crop\",\"trim\":{\"top\":747,\"left\":316,\"width\":3944,\"height\":2958}}]}",
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
        { data-search-exclude }

!!! Note
    All operations on variants require update permissions on objects of `_media` content type.

### Get Variant

For fetching images transformed with properties defined in variants use GET `https://api.flotiq.com/image/{width}x{height}/{id}/{fileName}.{extension}/variant/{variant-name}` endpoint, which functions the same as a regular [endpoint for retrieving media](https://flotiq.com/docs/API/media-library/#getting-files), but additionally accepts variant name, which should contain the name of the variant that you have defined for this media object.

The resulting image will be formatted according to the variant's properties you have defined.

## Transforming images without creating variants

There are two options for fetching transformed images from your media library without the need for defining variants for corresponding objects of `_media` content type definition.

The first one is to use the standard endpoint for fetching images and adding `?transform` query parameter to it that contains the same object for transformation a variant would, excluding the `name` key, for example:

GET `https://api.flotiq.com/image/0x0/id/fileName.ext?transform={"trim":{"top":0,"right":50,"bottom":50,"left":50,"width":200,"height":200}}`

Another way of retrieving transformed assets from the media library without creating a variant is to use a designated endpoint for such transformations. To use this endpoint, send the GET request to `https://api.flotiq.com/image/{width}x{height}/{id}/{fileName}.{extension}/transform/{transformation-type}/{parameters}`

For trimming the image, you have to provide `trim` value for `transformation-type` path parameter, and the following parameters: top,right,width,height; separated with commas, for example:

GET `https://api.flotiq.com/image/0x0/id/fileName.ext/transform/trim/50,50,200,200`

## Variants dashboard

Operations on variants are accessible through our dashboard. For more information visit here [dashboard for media library](https://flotiq.com/docs/panel/media-library/).

# Conclusion

Flotiq allows for the creation, management, and retrieval of variants, offering practical examples and response handling. By following these guidelines, users can efficiently optimize and customize media assets for various use cases, enhancing application performance and flexibility. Overall, this documentation serves as a valuable resource for developers looking to leverage Flotiq's capabilities for media transformation.
