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
- Transformation parameters: Specifies the details of the transformation(s), such as the amount to trim from each side of the dimensions to resize the image to.

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

Note that the variants key above is an optional key inside an object of type `_media`.

!!! Example

    ```
    {
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
    ```

<!-- todo zastanów się czy to w ogóle pisać i czy to dobre miejsce na to a jak już to rozwiń -->
!!! Note

- Media objects without any variants initially won't have the "variants" key in their object data. It will be automatically added when the first variant for that media is created.
- Removing all variants of an asset won't delete the "variants" key from object data.
- Variant names must be unique and follow the regex pattern: `^[_a-z]+$` (case insensitive).

## Transformation Types

Currently, the only acceptable type of transformation is `trim`. The transformations follow Cloudflare's transformation standards.
<!-- https://developers.cloudflare.com/images/transform-images/transform-via-workers -->

### Handling Variants

Endpoints for creating and removing variants require update permissions on `_media` CTD.

#### Create a New Variant

Endpoint: *(todo)*

#### Remove Variant

Endpoint: *(todo)*

#### Get Variant

Endpoint: *(todo)*

### Additional Endpoint Updates

- **Transform Media Without Creating Variant:**
  - The generic GET `/image/{width-height}/{key}` endpoint now accepts a `transform` query parameter. This parameter accepts the same body as a variant, excluding the `name` property.

- **New Endpoint for Transformation from URL Path:**
  *(Endpoint details to be specified)*

### Warning

Variant manipulation is performed by editing media objects directly. No additional API calls are needed beyond standard media operations.

# Transforming the asset with request

If you want to transform the file fetched from Flotiq without creating a variant, you can do that either by adding `transform` query parameter to your GET request that fetches the asset, or by using the endpoint below

<!-- TODO -->

### Conclusion

These updates provide enhanced flexibility in managing media assets by allowing the creation of variants with transformations. Developers can now efficiently manipulate media content to meet various display requirements.
