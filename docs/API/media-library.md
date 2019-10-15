#Media library

The process of uploading files to the media library consists of two steps:

1. Upload the file to `/api/media` endpoint (via a `POST` request). The reponse
   will be a JSON payload with information about the created entity.
    
    !!! hint
        You can also download files from Unsplash, to do this, enter the id of the Unsplash photo on `/api/unsplash/{id}` endpoint (via GET request), the photo will be automatically downloaded to the server. The response will be exactly the same as for image upload. 
    

2. Next step is to transfer the information about the saved file as a Content Object compatible with Content Type Definition of `_media` type to the `/api/v1/content/_media`  endpoint.

Both steps are described in details below.

##File upload

Because sending and storing files as their base64 hash is ineffective, files 
have to be uploaded to the Content Repository first. That way the entity URL can 
be used when creating a proper `_media` Content Object.

"File upload response with JSON information about file"
```json
{
    "id": "The id given by the backend by which the file on the disk is named",
    "extension": "Extension without dot",
    "fileName": "Full name of uploaded file",
    "mimeType": "Mime type of uploaded file",
    "size": Size of file in bytes,
    "type": "Type of the file, it can be 'image' or 'file'",
    "source": "Source of file, it can be 'disk' or 'unsplash'",
    "externalId": "Id of the photo on unsplash if it was downloaded from there",
    "url": "original/The id given by the backend + extension",
    "height": Height, or 0 for 'file' type,
    "width": Width, or 0 for 'file' type
}
```
    
The returned keys match the keys of the `_media` Content Type Definition.

##Content Type Definition

Structure of the `_media` Content Type Definition:
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
                "inputType": "text",
                "unique": false,
                "idTitlePart": true
            },
            "mimeType": {
                "inputType": "text",
                "unique": false
            },
            "size": {
                "inputType": "number",
                "unique": false
            },
            "width": {
                "inputType": "number",
                "unique": false
            },
            "height": {
                "inputType": "number",
                "unique": false
            },
            "url": {
                "inputType": "text",
                "unique": false
            },
            "externalId": {
                "inputType": "text",
                "unique": false
            },
            "source": {
                "inputType": "select",
                "unique": false,
                "options": ["disk","unsplash"]
            },
            "extension": {
                "inputType": "text",
                "unique": false
            },
            "type": {
                "inputType": "select",
                "unique": false,
                "options": ["file","image"]
            }
        }
    }
}
```

##Content Object

Saving the `_media` type object can only take place after the file has been 
saved on the server. At that point the object identifier is assigned. The `id` 
property is unique, final and immutable and is used to create the URI of the 
uploaded object. 


##Images resizing

Images are automatically scaled and saved for future use if the size requested by the user or generator does not yet exist.

##Viewing photos, returning files

Resized images are returned by endpoint `/image/{width}x{height}/{key}` where 
`width` and `height` are the dimensions of the scaled photo and key is its `id` and `extension`. 
To download the original photo, or download a non-photo file as width and height, 
enter `0`, e.g. `/image/0x0/afef92824.doc`.

!!! example 
    `image/1920x0/_media-5472384.jpg` will choose a photo with a width of 1920px and a proportional height of id `_media-5472384`, the file will be JPG. The extension must match original extension of uploaded file.
