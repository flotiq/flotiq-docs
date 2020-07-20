title: Flotiq Media Library | Flotiq docs
description: Learn more about the powerful Media Library that Flotiq offers.

#Media library

To upload the file to the media library, you need to send `POST` multipart request to `/api/media` endpoint. The response will be a Content Object of type `_media`.
    
!!! hint
    You can also download files from Unsplash, to do this, enter the id of the Unsplash photo on `/api/unsplash/{id}` endpoint (via `GET` request), the photo will be automatically downloaded to the server. The response will be the same as for image upload. 


??? "Deprecated, old, two steps way"
    The process of uploading files to the media library consists of two steps:
    
    1. Upload the file to `/api/media` endpoint (via a `POST` request). The response
       will be a JSON payload with information about the created entity.
        
        !!! hint
            You can also download files from Unsplash, to do this, enter the id of the Unsplash photo on `/api/unsplash/{id}` endpoint (via `GET` request), the photo will be automatically downloaded to the server. The response will be the same as for image upload. 
        
    
    2. Next step is to transfer the information about the saved file as a Content Object compatible with Content Type Definition of `_media` type to the `/api/v1/content/_media`  endpoint.
    
    We describe both steps in details below.

##File upload

Because sending and storing files as their base64 hash is ineffective, files have to be uploaded to the Content Repository first. To save the file as Content Object while uploading it, set the `save` flag to `1`.

!!! example "Example nodeJs image upload"
    ```js
    const fs = require(`fs`)
    const FormData = require(`form-data`)
    ...
    const form = new FormData();
    form.append(`file`, fs.createReadStream(file), file);
    form.append(`type`, `image`);
    form.append(`save`, 1);
    let json = await fetch(apiUrl + `/api/media`, {
        method: `POST`,
        body: form,
        headers: headers,
    }).then(res => res.json());
    console.log(json); //logs example object return shown below
    ```

!!! example "Example response"
    ```json
    {
        "id": "_media-456456",
        "extension": "jpg",
        "fileName": "example_image.jpg",
        "mimeType": "image/jpeg",
        "size": 45896,
        "type": "image",
        "source": "disk",
        "externalId": "",
        "url": "/image/0x0/_media-456456.jpg",
        "height": 300,
        "width": 150
    }
    ```

### Request parameters

| Parameter | Description |
| --------- | ----------- |
| file      | binary data of a file |
| type      | `image` for image types, `file` for everything else |
| save      | information if the file should be saved as the Content Object without sending another request, `0` or `1`, default `0`, for the intended way of saving images, use `1` |

??? "Deprecated, old, two steps way"

    Because sending and storing files as their base64 hash is ineffective, files have to be uploaded to the Content Repository first. That way, the entity URL can be used when creating a proper `_media` Content Object.
    
    To use this way, do not set the `save` flag or set it to `0`.
    
    The returned keys match the keys of the `_media` Content Type Definition.

##Content Type Definition

??? "Structure of the `_media` Content Type Definition:"
    ```json
    {
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
                        "fileName": {
                            "type": "string"
                        },
                        "mimeType": {
                            "type": "string"
                        },
                        "size": {
                            "type": "number"
                        },
                        "width": {
                            "type": "number"
                        },
                        "height": {
                            "type": "number"
                        },
                        "url": {
                            "type": "string"
                        },
                        "externalId": {
                            "type": "string"
                        },
                        "source": {
                            "type": "string"
                        },
                        "extension": {
                            "type": "string"
                        },
                        "type": {
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
                "fileName": {
                    "label": "File name",
                    "inputType": "text",
                    "unique": false,
                    "idTitlePart": true
                },
                "mimeType": {
                    "label": "MIME type",
                    "inputType": "text",
                    "unique": false
                },
                "size": {
                    "label": "Size",
                    "inputType": "number",
                    "unique": false
                },
                "width": {
                    "label": "Width",
                    "inputType": "number",
                    "unique": false
                },
                "height": {
                    "label": "Height",
                    "inputType": "number",
                    "unique": false
                },
                "url": {
                    "label": "Url",
                    "inputType": "text",
                    "unique": false
                },
                "externalId": {
                    "label": "External id",
                    "inputType": "text",
                    "unique": false
                },
                "source": {
                    "label": "Source",
                    "inputType": "select",
                    "unique": false,
                    "options": ["disk","unsplash"]
                },
                "extension": {
                    "label": "Extension",
                    "inputType": "text",
                    "unique": false
                },
                "type": {
                    "label": "Type",
                    "inputType": "select",
                    "unique": false,
                    "options": ["file","image"]
                }
            }
        }
    }
    ```

### Content Type Definition parameters

| Parameter  | Description |
| ---------- | ----------- |
| id         | The id is given by the backend by which the file on the disk is named. The `id` property is unique, final and immutable and is used to create the URI of the uploaded object. |
| extension  | File extension without dot |
| fileName   | Full name of uploaded file |
| mimeType   | Mime type of uploaded file |
| size       | Size of file in bytes |
| type       | Type of the file, it can be 'image' or 'file' |
| source     | Source of the file, it can be 'disk' or 'unsplash' |
| externalId | Id of the photo on unsplash if it was downloaded from there
| url        | Url to original image without API host (e.g. /image/0x0/_media-456456.jpg) |
| height     | Height, or 0 for 'file' type |
| width      | Width, or 0 for 'file' type |

##Content Object

Media upload endpoint creates Content Object automatically when you use `save = 1` parameter. It would be best if you only used `getMedia` and `listMedia` endpoints, as changing the `_media` objects can lead to unexpected behaviour.

??? "Deprecated, old, two steps way"

    Saving the `_media` type object can only take place after the file has been saved on the server. At that point, the object identifier is assigned. The `id` property is unique, final and immutable and is used to create the URI of the uploaded object. 


##Images resizing

Flotiq automatically scale images and save them for future, faster use, if the size requested by the user or generator does not yet exist.

##Viewing photos, returning files

Resized images are returned by endpoint `/image/{width}x{height}/{key}` where 
`width` and `height` are the dimensions of the scaled photo and key is its `id` and `extension`. 
To download the original photo, or download a non-photo file as width and height, 
enter `0`, e.g. `/image/0x0/_media-54723892824.doc`.

!!! example 
    `image/1920x0/_media-5472384.jpg` will choose a photo with a width of 1920px and a proportional height of id `_media-5472384`, the file will be JPG. The extension must match the original extension of the uploaded file.
