title: How to handle Content Type Definitions | Flotiq docs
description: How to handle Content Type Definitions in Flotiq


# Content Types

##API description

The CMS system API is divided into separate parts:

* internal system API
* user public API

The internal system API is used to define and list Content Types (models), which are [OpenAPI 3.0](https://swagger.io/docs/specification/about/) schemas.

The user public API exposes the user-defined Content Types (models) via a REST interface.

## Key concepts

* **Content Repository** - the headless part of the Content Management Platform.
* **Content Type** - a model of data that has been defined inside the Content Repository.
* **Content Type Definition** - a JSON payload that defines the Content Type, it's validation rules, etc.
* **Content Object** - an instance of a Content Type.


The central part of the CMS system is the Content Repository. It enables users to store different kinds of content within the system. The users are allowed to design their own content types and define them within the Content Repository by means of <abbr title="Content Type Definition - a JSON payload that defines the Content Type, it's validation rules, etc.">Content Type Definitions</abbr> (a concept similar to DTDs familiar from XML), described in a [JSON Schema](https://json-schema.org/) format.


Every <abbr title="Content Type Definition - a JSON payload that defines the Content Type, it's validation rules, etc.">CTD</abbr> that is created in the system is validated against the predefined schema of ``ContentTypeDefinitionSchema`` type. A detailed example will be discussed [below](#creating-new-content-types-via-api).

Once created the <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> becomes available in the system and <abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr>  of that type can be created, updated, deleted via API calls to their respective endpoints.  

Every <abbr title="Content Object - an instance of a Content Type.">Content Object</abbr> uploaded to the repository requires a <abbr title="Content Type Definition - a JSON payload that defines the Content Type, it's validation rules, etc.">Content Type Definition</abbr> already present in the system. 


Throughout this page, we will follow the example of defining a simple <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> of a BlogPost. 

Example: 
!!! note "Example: Content Type Definition for BlogPost"
    * Id – string, unique, required 
    * Title – string, required 
    * PostContent – string, required 


##API token

API token (described in requests below as `YOUR API TOKEN`) should be obtained from the User profile view of the Flotiq panel.  All examples here have authentication in the request header, but you can also use `?auth_token=YOUR_API_TOKEN` in the request URL.

## Creating new Content Types 

A new <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> can be created either by sending a properly formatted POST request to the ``/api/v1/internal/contenttype`` endpoint or through the Content Modeler tool provided with the platform.


### Creating new Content Types via API

The API endpoint ``/api/v1/internal/contenttype`` can be used to interact with <abbr title="Content Type Definition - a JSON payload that defines the Content Type, it's validation rules, etc.">Content Type Definitions</abbr> inside the Content Repository. The endpoint documentation is provided in the API docs and describes the following actions:

![](images/contentObject7.jpg)


Creating a new <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> is simply a ``POST`` call with a payload similar to:

??? "Content Type POST payload"
    ```json
        {
            "name": "blogposts",
            "label": "Blog Posts",
            "workflowId": "_workflow-1",
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
                                "type": "string"
                            },
                            "postContent": {
                                "type": "string"
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
                        "inputType": "text",
                        "unique": true
                    },
                    "postContent": {
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

`name` is the name of the <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> and name of the endpoints that will be generated to handle requests with <abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr>  of that type.

`label` is only for displaying the name correctly on the CMS panel.

`workflowId` informs which type of workflow (by its `id`) should object of this type abide. Possible workflows can be obtained from `/api/v1/content/_workflow`, as the workflow is the internal <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> of the system.

The `schemaDefinition` part of the JSON payload is based on the bare JSON Schema and is fully compatible. It holds information about properties of the <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">CT</abbr> (in the `properties` key), its types and which properties are required (`required` key). It always should have `"type":"object"`, as it is an object, and `"additionalProperties": false` to ensure that API users will not post garbage to the objects of this CTD. To ensure that all objects have id property <abbr title="Content Type Definition - a JSON payload that defines the Content Type, it's validation rules, etc.">CTD</abbr> also should have information about the connection with `AbstractContentTypeSchemaDefinition` using:
```json
"allOf": [
    {
        "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
    }
],
```

In the case of this example, it will add two properties, `title` and `postContent` which are both strings and required.

`metaDefinition` is used to tell CMS panel how to render a form for the Content Object, it holds information about the order of the properties (`order` key, which should contains all properties of the object), and about type and validation of the field, it also contains information about relations of the object with another Content Types. 

In this case, Blog Post will have `title` property which will be unique and will render as text input in CMS panel and `postContent` which can be duplicated and will be presented as CKEditor input in CMS panel. First input in the form in CMS panel will be `title` input, and second will be `postContent`.

Full curl request:
```
curl -X POST "https://api.flotiq.com/api/v1/internal/contenttype" -H 'accept: */*' -H 'X-AUTH-TOKEN: YOUR_API_KEY' -H 'Content-Type: application/json' --data-binary '{"name":"blogposts","label":"Blog Posts","workflowId":"_workflow-1","schemaDefinition":{"type":"object","allOf":[{"$ref":"#/components/schemas/AbstractContentTypeSchemaDefinition"},{"type":"object","properties":{"title":{"type":"string"},"postContent":{"type":"string"}}}],"required":["title","postContent"],"additionalProperties":false},"metaDefinition":{"propertiesConfig":{"title":{"inputType":"text","unique":true},"postContent":{"inputType":"richtext","unique":false}},"order":["title","postContent"]}}'
```

After such call is made and <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> is created - the User API is immediately extended to support interaction with this new Content Type:

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_4c8ba2ed8288f9b7a84769a62d1022aa.png)

All Content Types have automatically added properties from `AbstractContentTypeSchemaDefinition`; they are:

* id - string identifier of Content Object, required in all requests, unique within the Content Type,
* internal - object necessary to proper work of CMS backend (information about dates of creation and update, workflow type attached to Content Type, the whole object is described in JSON below). 

??? "Schema of Abstract Content Type"
    ```json
        "AbstractContentTypeSchemaDefinition": {
            "type": "object",
            "properties": {
                "id": {
                    "type": "string"
                },
                "internal": {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                        "createdAt", "updatedAt", "deletedAt", "contentType"
                    ],
                    "properties": {
                        "contentType": {
                            "type": "string"
                        },
                        "createdAt": {
                            "type": "string"
                        },
                        "updatedAt": {
                            "type": "string"
                        },
                        "deletedAt": {
                            "type": "string"
                        },
                        "_workflow": {
                            "type": "object"
                        }
                    }
                }
            },
            "required": [
                "id"
            ]
        },
    ```

Property types (as of `schemaDefinition` properties), recognized by CMS panel:

??? "Property types"
    | type    | Description                                                                                                                                  | Additional keys in property | Description                                                                                                                                    |
    | ------- | -------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
    | string  | Any string data that includes date and files                                                                                                 | none allowed                |
    | number  | Any number, integer, float and double                                                                                                        | none allowed                |
    | boolean | Represents two values `true` and `false`. Note that truthy and falsy values such as "true", "", 0 or null are not considered boolean values. | none allowed                |
    | array   | Used for lists or relations.                                                                                                                 | items                       | For lists: it has to be an object containing `{"$ref": "#/components/schemas/DataSource"}`, as the items of the array are objects described in DataSource schema.<br>For list items: it should be a valid json schema following the same restrictions as wrapping schema |
    |         |                                                                                                                                              | minItems                    | `0` for a not required property, and `1` for required property                                                                                   |


Input types in `metaDefinition` of properties:

??? "Meta definition"
    | inputType  | Possible for schema type | Description                                                                                                        | Additional keys in property | Description                                           | Additional keys     | Description |
    | ---------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------ | --------------------------- | ----------------------------------------------------- | ------------------- | ----------- |
    | text       | string                   | Renders text input in form                                                                                         | unique                      | *                                                     | none allowed        |
    | textarea   | string                   | Renders textarea in form                                                                                           | unique                      | *                                                     | none allowed        |
    | richtext   | string                   | Renders CKEditor in form                                                                                           | unique                      | *                                                     | none allowed        |
    | email      | string                   | Renders email input in form                                                                                        | unique                      | *                                                     | none allowed        |
    | number     | number                   | Renders number input in form, min is 0, max is MAX INT                                                             | unique                      | *                                                     | none allowed        |
    | radio      | string                   | Renders radio input, options are taken from `options` property                                                     | unique                      | *, Can only be `false`                                | none allowed        |
    |            |                          |                                                                                                                    | options                     | Array of string options possible for the radio input  | none allowed        |
    | checkbox   | boolean                  | Renders single checkbox input returning `true`/`false` value                                                       | unique                      | *, Can only be `false`                                | none allowed        |
    | select     | string                   | Renders single item select input, options are taken from `options` property                                        | unique                      | *                                                     | none allowed        |
    |            |                          |                                                                                                                    | options                     | Array of string options possible for the select input | none allowed        |
    | object     | array                    | Renders one or multiple forms for nested `meta definition` element                                                 | items                       | `Meta definition` for single list item                | none allowed        |
    | datasource | array                    | Renders picker for choosing the objects of specified or any other Content Type, depending on `validation` property | unique                      | *                                                     | none allowed        |
    |            |                          |                                                                                                                    | validation                  | Object contains restrictions for datasource           | relationContenttype | Name of the Content Type to which relation should be restricted, key should not be present if any Content Type can be attached |
    |            |                          |                                                                                                                    |                             |                                                       | relationMultiple    | Boolean value informing if the array should have only one ora can have more elements |

    *Information if the value of the property should be unique in all object of the specified type. 

### Creating Content Types through the Content modeller

It is described in the public part of the documentation.

### Listing Content Types

To get the list of <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Types</abbr> you need to `GET` it on `/api/v1/internal/contenttype`. It returns the paginated list of Content Types. It can be filtered and limited. 

??? Response
    ```json
    {
      "total_count": 6,
      "total_pages": 1,
      "current_page": 1,
      "count": 6,
      "data": [
        {
          "id": "853b73fe-fb28-11e9-a032-164983a8ff87",
          "name": "_creator_content_container",
          "label": "Creator Content Container",
          "workflowId": null,
          "schemaDefinition": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
              },
              {
                "type": "object",
                "properties": {
                  "name": {
                    "type": "string"
                  },
                  "content": {
                    "type": "object"
                  }
                },
              }
            ],
            "required": [
              "name",
              "content"
            ],
            "additionalProperties": false
          },
          "metaDefinition": {
            "order": [
              "name",
              "content"
            ],
            "propertiesConfig": {
              "id": {
                "unique": true,
                "inputType": "text"
              },
              "name": {
                "unique": true,
                "inputType": "text"
              },
              "content": {
                "unique": false,
                "inputType": "text"
              }
            }
          },
          "deletedAt": null,
          "createdAt": "2019-10-30T15:18:26.000000+0000",
          "updatedAt": null
        },
        {
          "id": "d2c60a5b-fa31-11e9-886d-3afe2f8d7a3c",
          "name": "_editBlock",
          "label": "_editBlock",
          "workflowId": "",
          "schemaDefinition": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
              },
              {
                "type": "object",
                "properties": {
                  "hash": {
                    "type": "string"
                  },
                  "user": {
                    "type": "string"
                  },
                  "elementId": {
                    "type": "string"
                  },
                  "elementType": {
                    "type": "string"
                  }
                }
              }
            ],
            "required": [
              "user",
              "hash",
              "elementId",
              "elementType"
            ],
            "additionalProperties": false
          },
          "metaDefinition": {
            "order": [
              "user",
              "hash",
              "elementId",
              "elementType"
            ],
            "propertiesConfig": {
              "hash": {
                "unique": true,
                "options": [],
                "inputType": "text"
              },
              "user": {
                "unique": false,
                "options": [],
                "inputType": "text"
              },
              "elementId": {
                "unique": false,
                "options": [],
                "inputType": "text"
              },
              "elementType": {
                "unique": false,
                "options": [],
                "inputType": "text"
              }
            }
          },
          "deletedAt": null,
          "createdAt": "2019-10-29T09:52:30.000000+0000",
          "updatedAt": null
        },
        {
          "id": "1e64237a-f4db-11e9-991e-d2c03bd6f499",
          "name": "_media",
          "label": "Media",
          "workflowId": "",
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
                "unique": false,
                "options": [],
                "inputType": "text"
              },
              "size": {
                "unique": false,
                "options": [],
                "inputType": "number"
              },
              "type": {
                "unique": false,
                "options": [
                  "image",
                  "file"
                ],
                "inputType": "select"
              },
              "width": {
                "unique": false,
                "options": [],
                "inputType": "number"
              },
              "height": {
                "unique": false,
                "options": [],
                "inputType": "number"
              },
              "source": {
                "unique": false,
                "options": [
                  "disk",
                  "unsplash"
                ],
                "inputType": "select"
              },
              "fileName": {
                "unique": false,
                "options": [],
                "inputType": "text"
              },
              "mimeType": {
                "unique": false,
                "options": [],
                "inputType": "text"
              },
              "extension": {
                "unique": false,
                "options": [],
                "inputType": "text"
              },
              "externalId": {
                "unique": false,
                "options": [],
                "inputType": "text"
              }
            }
          },
          "deletedAt": null,
          "createdAt": "2019-10-22T14:49:15.000000+0000",
          "updatedAt": "2019-10-30T11:15:47.000000+0000"
        },
        {
          "id": "edf6794c-f4da-11e9-991e-d2c03bd6f499",
          "name": "_workflow",
          "label": "Workflow",
          "workflowId": null,
          "schemaDefinition": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
              },
              {
                "type": "object",
                "properties": {
                  "name": {
                    "type": "string"
                  },
                  "definition": {
                    "type": "string",
                    "description": "Workflow definition - key from workflows.yaml"
                  }
                },
              }
            ],
            "required": [
              "id",
              "name",
              "definition"
            ],
            "additionalProperties": false
          },
          "metaDefinition": {
            "order": [
              "name",
              "definition"
            ],
            "propertiesConfig": {
              "name": {
                "unique": true,
                "inputType": "text"
              },
              "definition": {
                "unique": false,
                "inputType": "textarea"
              }
            }
          },
          "deletedAt": null,
          "createdAt": "2019-10-22T14:47:54.000000+0000",
          "updatedAt": null
        },
        {
          "id": "0b1809f9-f4db-11e9-991e-d2c03bd6f499",
          "name": "_workflow_state",
          "label": "Workflow state",
          "workflowId": null,
          "schemaDefinition": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
              }
              {
                "type": "object",
                "properties": {
                  "state": {
                    "type": "string",
                    "description": "State name (eg. draft, published)"
                  },
                  "workflow": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/DataSource"
                    },
                    "maxItems": 1,
                    "minItems": 1,
                    "description": "Link to workflow definition"
                  },
                  "content_type": {
                    "type": "string"
                  },
                  "content_object_id": {
                    "type": "string",
                    "description": "Pointing to ContentObject. @todo Use relation"
                  }
                },
              }
            ],
            "required": [
              "id",
              "content_object_id",
              "content_type",
              "state",
              "workflow"
            ],
            "additionalProperties": false
          },
          "metaDefinition": {
            "order": [
              "content_object_id",
              "content_type",
              "state",
              "workflow"
            ],
            "propertiesConfig": {
              "state": {
                "unique": false,
                "inputType": "text"
              },
              "workflow": {
                "unique": false,
                "inputType": "datasource",
                "validation": {
                  "relationMultiple": false,
                  "relationContenttype": "_workflow"
                }
              },
              "content_type": {
                "unique": false,
                "inputType": "text"
              },
              "content_object_id": {
                "unique": false,
                "inputType": "text"
              }
            }
          },
          "deletedAt": null,
          "createdAt": "2019-10-22T14:48:43.000000+0000",
          "updatedAt": null
        },
        {
          "id": "77721433-f727-11e9-bf7c-129df7ebe82d",
          "name": "blogposts",
          "label": "Blog Posts",
          "workflowId": "_workflow-1",
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
                "unique": false,
                "inputType": "datasource",
                "validation": {
                  "relationMultiple": true,
                  "relationContenttype": "tag"
                }
              },
              "media": {
                "unique": false,
                "inputType": "datasource",
                "validation": {
                  "relationMultiple": true,
                  "relationContenttype": "_media"
                }
              },
              "title": {
                "unique": false,
                "inputType": "text"
              },
              "content": {
                "unique": false,
                "inputType": "richtext"
              }
            }
          },
          "deletedAt": null,
          "createdAt": "2019-10-25T13:00:50.000000+0000",
          "updatedAt": "2019-10-30T20:30:59.000000+0000"
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

## Content Objects

Once a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> has been defined in the system - the user can create <abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr>  of that Content Type. This is done either directly through the API or via the convenient Content Entry tools provided within the Content Management Platform.

### Authoring content through the API

The supporting endpoints of a given <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> allow the user to perform basic REST operations 

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_4c8ba2ed8288f9b7a84769a62d1022aa.png)


For a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> defined according to the example described above, a very simple POST payload can be sent to the supporting endpoint to create a new Content Object:

``` json
{
  "id": "123123123",
  "title": "New object",
  "postContent": "This will be the new <b>content</b>"
}
```

Full curl request:

```
curl -X POST "https://api.flotiq.com/api/v1/content/blogposts" -H "accept: */*" -H "X-AUTH-TOKEN: YOUR API TOKEN" -H "Content-Type: application/json" -d "{\"id\":\"123123123\",\"title\":\"New object\",\"postContent\":\"This will be the new <b>content</b>\"}"
```


which should result in a ``200`` server response containing the details of the created object:

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_a505c0503a97ac4961b81daee835d9c6.png)


If a property is required in the <abbr title="Content Type Definition - a JSON payload that defines the Content Type and it's validation rules">Content Type Definition</abbr> of the object being added, API will respond with `400` response and will list validation errors in the response body.

For example for request with payload with the missing title:
```json
{
  "id": "123123123",
  "postContent": "This will be the new <b>content</b>"
}
```

The server will respond with:
```json
{
  "title": [
    "The property title is required"
  ]
}
```

![](images/contentObject3.jpg)


If a property should be unique, API will respond with `400` response and will list validation errors in the response body, exactly like with required fields.

If you would post the same object as in the first example the server will response with:

```json
{
  "title": [
    "This value is already used"
  ],
  "id": [
    "This value is already used"
  ]
}
```


#### Batch content upload

There is a way to add up to 100 of Content Objects at once. It is possible by using `/batch` endpoint (in our example the url would be `https://api.flotiq.com/api/v1/content/blogposts/batch`). It can be only `insert` or `insert or update` operation. To use `insert or update` you need to set `updateExisting` to `true` in query. 

All objects must meet the same conditions as when adding a single object. The only difference is array of objects in request body instead of one object.

Updating one blog post and adding one new:

!!! Example
    
    ```
    curl 'http://localhost:8069/api/v1/content/blogpost/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object","postContent":"This will be the new <b>content</b>"},{"id":"123123124","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 200):
    ```json
    {
        "batch_total_count": 2,
        "batch_success_count": 2,
        "batch_error_count": 0,
        "errors": []
    }
    ```
    
Trying updating one blog post and adding one new with wrong data
    
!!! Example
    
    ```
    curl 'http://localhost:8069/api/v1/content/blogpost/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object"},{"id":"123123124","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 400):
    ```json
    {
        "batch_total_count": 2,
        "batch_success_count": 1,
        "batch_error_count": 1,
        "errors": [
          {
            "id": "123123123",
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
    curl 'http://localhost:8069/api/v1/content/blogpost/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object","content": "This will be the new <b>content</b>"},{"id":"123123123","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 400):
    ```json
    {
      "data": [
        "There are duplications in object data, key: id"
      ]
    }
    ```

Response parameters:

| Parameter           | Description |
| ------------------- | ----------- |
| batch_total_count   | number of elements sent in the request, present when there is no duplications in data |
| batch_success_count | number of correct elements sent in the request, present when there is no duplications in data |
| batch_error_count   | number of incorrect elements sent in the request, present when there is no duplications in data |
| errors              | array of errors in the elements, errors are object containing id of the object and list of errors, present when there is no duplications in data |
| data                | present only when there are duplications in data, listing keys containing duplications (see example above) | 

### Listing content through the API

| Parameter       | Description |
| --------------- | ----------- |
| limit           | Numer of objects on page, default `20` |
| page            | Number of the requested page, 1-based, default `1` |
| order_by        | What field should the list be ordered by, possible values are based on content type schema |
| order_direction | Order direction, possible values: `asc`, `desc`, default `asc` |
| hydrate         | If you want to hydrate datasources in object you need to set it to `1`, it will hydrate one level of datasources in objects, you can also use this parameter when requesting single object |
| filters         | Json encoded array of objects containing conditions on which the list of CO should be filtered, the object key is name of parameter (eg. `title`) and it should have 2 keys, `type` describing how list should be filtered, and `filter` with filter query, both parameters should be string, you can filter on every subset of object parameters including `internal` parameters (eg. `internal.created_at`) |

Filter types

| Type               | Description                                    |
| ------------------ | ---------------------------------------------- |
| equals             | Object parameter must be equal to `filter`     |
| notEquals          | Object parameter must not be equal to `filter` |
| contains           | Object parameter must contain `filter`         |
| notContains        | Object parameter must not contain `filter`     |
| startsWith         | Object parameter must start with `filter`      |
| endsWith           | Object parameter must end with `filter`        |
| lessThanOrEqual    | Object parameter must be less or equal to `filter` |
| lessThan           | Object parameter must be less than filter      |
| greaterThanOrEqual | Object parameter must be greater or equal than `filter` |
| greaterThan        | Object parameter must be greater than `filter` |
| inRange            | Object parameter must be between `filter` and `filter2`, it is only filter type that have 3 keys in filter object |

Example response:
```json
{
  "total_count": 1,
  "total_pages": 1,
  "current_page": 1,
  "count": 1,
  "data": [
    {
      "id": "123123123",
      "title": "New object",
      "postContent": "This will be the new <b>content</b>",
      "internal": {
        "createdAt": "2019-10-25T20:22:37+00:00",
        "deletedAt": "",
        "updatedAt": "2019-10-30T20:32:42+00:00",
        "contentType": "blogposts"
      }
    }
  ]
}
```

**Filtering by relation**, for example "Show products in category category-1" is possible using [JsonPath](https://github.com/json-path/JsonPath) standard.
You have to care about encoding url params. Dots should also be converted to ASCII codes, for example:

1. Using JsonPath, product category path is `categories[*].dataUrl`
1. Expected value is `/api/v1/content/categories/category-1`
1. Raw query: `GET /api/v1/content/products?categories[*].dataUrl=/api/v1/content/categories/category-1`
1. Encoded query: `GET /api/v1/content/products?categories%255B*%255D%2EdataUrl=%2Fapi%2Fv1%2Fcontent%2Fcategories%2Fcategory-1`

### Updating content through the API

When updating the object (`PUT` requests), all properties have to be present in the request body, as the object data are replaced with the request body. The id property should never be changed in `PUT` requests. Validation of update request works the same as in saving requests.

### Deleting content through the API

Deleting of the object is done as the soft delete, it will be still in the database, but not accessible by API. It can be restored directly in the database, by setting `deleted_at` as `NULL`. 

### Authoring content through the Content Entry component

It is described in the public part of the documentation. 
