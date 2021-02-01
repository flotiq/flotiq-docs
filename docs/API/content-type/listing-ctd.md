title: How to list Content Type Definitions | Flotiq docs
description: How to list Content Type Definitions in Flotiq


# Listing Content Types

To get the list of <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Types</abbr> you need to `GET` it on `/api/v1/internal/contenttype`. It returns the paginated list of Content Types. It can be filtered and limited. 

??? Response
    ```json
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
                    "type": "string"
                  },
                  "size": {
                    "type": "number"
                  },
                  "type": {
                    "type": "string"
                  },
                  "width": {
                    "type": "number"
                  },
                  "height": {
                    "type": "number"
                  },
                  "source": {
                    "type": "string"
                  },
                  "fileName": {
                    "type": "string"
                  },
                  "mimeType": {
                    "type": "string"
                  },
                  "extension": {
                    "type": "string"
                  },
                  "externalId": {
                    "type": "string"
                  }
                },
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
                "options": [],
                "inputType": "text"
              },
              "size": {
                "label": "Size",
                "unique": false,
                "options": [],
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
                "options": [],
                "inputType": "number"
              },
              "height": {
                "label": "Height",
                "unique": false,
                "options": [],
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
                "options": [],
                "inputType": "text"
              },
              "mimeType": {
                "label": "MIME type",
                "unique": false,
                "options": [],
                "inputType": "text"
              },
              "extension": {
                "label": "Extension",
                "unique": false,
                "options": [],
                "inputType": "text"
              },
              "externalId": {
                "label": "External id",
                "unique": false,
                "options": [],
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
              }
              {
                "type": "object",
                "properties": {
                  "tags": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/DataSource"
                    },
                    "minItems": 0
                  },
                  "media": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/DataSource"
                    },
                    "minItems": 0
                  },
                  "title": {
                    "type": "string"
                  },
                  "content": {
                    "type": "string"
                  }
                },
              }
            ],
            "required": [
              "title"
            ],
            "additionalProperties": false
          },
          "metaDefinition": {
            "order": [
              "title",
              "content",
              "tags",
              "media"
            ],
            "propertiesConfig": {
              "tags": {
                "label": "Tags",
                "unique": false,
                "inputType": "datasource",
                "validation": {
                  "relationMultiple": true,
                  "relationContenttype": "tag"
                }
              },
              "media": {
                "label": "Media",
                "unique": false,
                "inputType": "datasource",
                "validation": {
                  "relationMultiple": true,
                  "relationContenttype": "_media"
                }
              },
              "title": {
                "label": "Title",
                "unique": false,
                "inputType": "text"
              },
              "content": {
                "label": "Content",
                "unique": false,
                "inputType": "richtext"
              }
            }
          },
          "deletedAt": null,
          "createdAt": "2019-10-25T13:00:50.000000+0000",
          "updatedAt": "2020-07-20T16:34:11.000000+0000"
        }
      ]
    }
    ```

`total_count` is the number of Content Types in the database (if any filters are present, it's a number of filtered Content Types).

`total_pages` is the number of pages available to the user.

`current_page` is currently returned page.

`count` number of elements in `data` key, can't be more than limit set in request (default 20).

`data` list of Content Types, every object contains all data.

Possible request parameters:

| Parameter       | Description |
| --------------- | ----------- |
| limit           | Numer of objects on page, default `20` |
| page            | Number of the requested page, 1-based, default `1` |
| order_by        | What field should list be ordered by, possible values: `name`, `id`, `createdAt`, `updatedAt`, default `name` |
| order_direction | Order direction, possible values: `asc`, `desc`, default `asc` |
| name            | Used for filtering Content Types by name, filtering is case insensitive and returns everything containing parameter value, default empty |

Example request with parameters:
``` 
curl -X GET "https://api.flotiq.com/api/v1/internal/contenttype?page=1&limit=20&order_by=name&order_direction=asc&name=blog" -H "X-AUTH-TOKEN: YOUR API TOKEN" -H "accept: application/json"
```
