title: Get your own Open Api Schema | Flotiq docs
description: How to get your open API schema

# Open API schema

You can generate Full Open API Schema for every Content Type Definition 
in your account or scope it making User Defined API key as described [here](/docs/API/#user-defined-api-keys).

## Getting your Full Open API Schema

If you want to get your Open API Schema from Flotiq, 
you have to make a call at the following endpoint with your Read-only API key or Read and write API key 
(using a Web browser, Postman or Insomnia):

`
https://api.flotiq.com/api/v1/open-api-schema.json
`

Or run a simple curl request in the terminal:

```
curl -X GET "https://api.flotiq.com/api/v1/open-api-schema.json" \
     -H 'accept: */*' \
     -H 'X-AUTH-TOKEN: YOUR_API_KEY' \
     -H 'Content-Type: application/json'
```

Possible request parameters:

| Parameter | Description                                                                                          |
| --------- | ---------------------------------------------------------------------------------------------------- |
| version   | version of API Schema, possible values: `3` - default for Open API Schema 3.0, `2` - for Swagger 2.0 |
| user_only | should the schema be rendered without system endpoints, default `false`                              |

Version 3 is compatible with Open API tools
([SDK generator](https://github.com/OpenAPITools/openapi-generator), [swagger editor](https://editor.swagger.io/))
and is used internally for all Flotiq operations.
Version 2 is shared for working with Microsoft tools
([Azure Logic Apps](https://azure.microsoft.com/en-us/services/logic-apps/), [Microsoft Flow](https://flow.microsoft.com/pl-pl/)).

If the standard schema does not work with the tool of your choice, please try using user_only schema,
as not all tools can handle the whole Open API Schema format.

??? "Response for full version 3"

    Example curl request
    ```
    curl -X GET "https://api.flotiq.com/api/v1/open-api-schema.json" \ 
         -H 'accept: */*' \
         -H 'X-AUTH-TOKEN: YOUR_API_KEY' \
         -H 'Content-Type: application/json'
    ```

    Response
    ```
    {
      "openapi": "3.0.0",
      "info": {
        "description": "## Getting started\n\n This is your Flotiq User API that allows you to access your data through the Content API that you defined.\n\n ### Access to data\n\n There are several methods that you can use to access your data:\n * Live API docs - available via <code>Try it out</code> button available next to each endpoint \n * Copying example code on the right side of each endpoint\n * By downloading the SDKs available in mulitple languages.\n * By downloading the Postman collection and importing it into Postman.\n\n\n Each of these methods is described in length in the [user documentation](https://flotiq.com/docs/).\n\n ### Authorization\n\n In order to make use of the provided documentation, example code, SDKs and so on - you will need to pull out your API key. We recommend that you start with the ReadOnly API Key which will allow you to make all the `GET` requests but will error-out when you try to modify content. Please remember to replace the key for `POST`, `PUT` and `DELETE` calls.\n\n It's also possible to use scoped API keys - you can create those in the API keys section of the Flotiq user interface. This will allow you to create a key that only authorizes access to a specific content type (or a set of content types, if you choose so). Read more about how to use and create API keys in the [API keys documentation](https://flotiq.com/docs/API/).\n\n ## Object access\n\n Once you define a Content Type it will become available in your Content API as a set of endpoints that will allow you to work with objects:\n\n * create\n * list\n * update\n * delete\n * batch create\n * retrieve single object.\n\n### Hydration\n\n When you build Content Types that have relation to others your objects will optionally support hydration of related entities. The endpoints that support object retrieval accept a `hydrate` parameter, which can be used to easily fetch hydrated objects. Since this breaks the standard REST concepts - it's not enabled by default, but it's a very handy feature that allows to reduce the amount of HTTP requests sent over the wire and we strongly recommend to use it.",
        "title": "Flotiq User API",
        "version": "2.0.1",
        "contact": {
          "name": "Flotiq Developers",
          "email": "hello@flotiq.com",
          "url": "https://flotiq.com"
        },
        "x-logo": {
          "url": "https://editor.flotiq.com/fonts/fq-logo.svg",
          "altText": "Flotiq User API"
        }
      },
      "x-tagGroups": [
        {
          "name": "User API",
          "tags": [
            "Content: Blog posts",
            "Content: Media"
          ]
        },
        {
          "name": "Flotiq API",
          "tags": [
            "Search API",
            "Internal",
            "Media",
            "GraphQL"
          ]
        }
      ],
      "servers": [
        {
          "url": "https://api.flotiq.com",
          "description": "Flotiq Live"
        }
      ],
      "security": [
        {
          "HeaderApiKeyAuth": []
        }
      ],
      "components": {
        "securitySchemes": {
          "HeaderApiKeyAuth": {
            "description": "Personal Auth token generated for user in Headless CMS application",
            "type": "apiKey",
            "in": "header",
            "name": "X-AUTH-TOKEN"
          }
        },
        "schemas": {
          "ContentTypeDefinitionSchema": {
            "type": "object",
            "description": "Representation of content type definition in CMS",
            "properties": {
              "name": {
                "type": "string",
                "minLength": 1
              },
              "label": {
                "type": "string",
                "minLength": 1
              },
              "workflowId": {
                "type": "string"
              },
              "schemaDefinition": {
                "type": "object",
                "description": "JSON Schema object defining structure. Extending AbstractContentTypeSchemaDefinition"
              },
              "metaDefinition": {
                "type": "object",
                "description": "Meta properties for schema definition",
                "$ref": "#/components/schemas/AbstractContentTypeMetaDefinition"
              },
              "internal": {
                "type": "boolean"
              }
            },
            "required": [
              "name",
              "label",
              "schemaDefinition",
              "metaDefinition"
            ],
            "additionalProperties": false,
            "example": {
              "name": "products",
              "label": "Products",
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
                      }
                    }
                  }
                ],
                "required": [
                  "title"
                ]
              },
              "metaDefinition": {
                "propertiesConfig": {
                  "title": {
                    "inputType": "text",
                    "label": "Title",
                    "unique": true
                  }
                },
                "order": [
                  "title"
                ]
              }
            }
          },
          "AbstractContentTypeSchemaDefinition": {
            "type": "object",
            "properties": {
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
              "id"
            ]
          },
          "AbstractContentTypeSchemaDefinitionWithoutInternal": {
            "type": "object",
            "properties": {
              "id": {
                "type": "string",
                "description": "Unique ID of the object"
              }
            },
            "required": [
              "id"
            ]
          },
          "AbstractContentTypeMetaDefinition": {
            "type": "object",
            "description": "Meta definition to describe schema - add unique, fields labels",
            "additionalProperties": false,
            "required": [
              "propertiesConfig",
              "order"
            ],
            "properties": {
              "propertiesConfig": {
                "type": "object",
                "additionalProperties": {
                  "$ref": "#/components/schemas/AbstractPropertiesConfig"
                }
              },
              "order": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "uniqueItems": true
              }
            }
          },
          "DataSource": {
            "type": "object",
            "description": "Represents link between data stored internally inside CMS or external",
            "additionalProperties": false,
            "properties": {
              "dataUrl": {
                "type": "string"
              },
              "type": {
                "type": "string",
                "enum": [
                  "internal",
                  "external"
                ],
                "default": "internal"
              }
            },
            "required": [
              "dataUrl",
              "type"
            ]
          },
          "AbstractPropertiesConfig": {
            "type": "object",
            "additionalProperties": false,
            "required": [
              "label",
              "inputType",
              "unique"
            ],
            "properties": {
              "label": {
                "type": "string"
              },
              "inputType": {
                "type": "string",
                "enum": [
                  "text",
                  "richtext",
                  "textarea",
                  "textMarkdown",
                  "email",
                  "number",
                  "radio",
                  "checkbox",
                  "select",
                  "datasource",
                  "object",
                  "geo"
                ]
              },
              "unique": {
                "type": "boolean"
              },
              "readonly": {
                "type": "boolean"
              },
              "hidden": {
                "type": "boolean"
              },
              "validation": {
                "type": "object",
                "additionalProperties": false,
                "properties": {
                  "relationMultiple": {
                    "type": "boolean"
                  },
                  "relationContenttype": {
                    "type": "string"
                  }
                }
              },
              "options": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "uniqueItems": true
              },
              "helpText": {
                "type": "string"
              },
              "isTitlePart": {
                "type": "boolean"
              },
              "items": {
                "type": "object",
                "$ref": "#/components/schemas/AbstractContentTypeMetaDefinition"
              }
            }
          },
          "SystemListProperties": {
            "type": "object",
            "additionalProperties": false,
            "required": [
              "total_count",
              "count",
              "total_pages",
              "current_page"
            ],
            "properties": {
              "total_count": {
                "type": "number",
                "example": 1
              },
              "count": {
                "type": "number",
                "example": 1
              },
              "total_pages": {
                "type": "number",
                "example": 1
              },
              "current_page": {
                "type": "number",
                "example": 1
              }
            }
          },
          "SearchResponse": {
            "type": "object",
            "additionalProperties": false,
            "allOf": [
              {
                "$ref": "#/components/schemas/SystemListProperties"
              },
              {
                "properties": {
                  "data": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "properties": {
                        "score": {
                          "type": "number"
                        },
                        "item": {
                          "type": "object",
                          "description": "Source content object stored in Headless CMS"
                        }
                      }
                    }
                  },
                  "summary": {
                    "type": "object",
                    "properties": {
                      "aggregations": {
                        "type": "object"
                      }
                    }
                  }
                },
                "additionalProperties": true
              }
            ]
          },
          "ContentTypeListResponse": {
            "type": "object",
            "additionalProperties": false,
            "allOf": [
              {
                "$ref": "#/components/schemas/SystemListProperties"
              },
              {
                "properties": {
                  "data": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/ContentTypeDefinitionSchema"
                    }
                  }
                }
              }
            ]
          },
          "BatchResponseError": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
              "batch_total_count": {
                "type": "number"
              },
              "batch_success_count": {
                "type": "number"
              },
              "batch_error_count": {
                "type": "number"
              },
              "errors": {
                "type": "array",
                "items": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "string"
                    },
                    "errors": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      }
                    }
                  }
                }
              }
            },
            "example": {
              "batch_total_count": 2,
              "batch_success_count": 0,
              "batch_error_count": 2,
              "errors": [
                {
                  "id": "test-1",
                  "errors": {
                    "name": [
                      "The property name is required"
                    ]
                  }
                },
                {
                  "id": "test-2",
                  "errors": {
                    "name": [
                      "The property name is required"
                    ]
                  }
                }
              ]
            }
          },
          "BatchResponseSuccess": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
              "batch_total_count": {
                "type": "number"
              },
              "batch_success_count": {
                "type": "number"
              },
              "batch_error_count": {
                "type": "number"
              },
              "errors": {
                "type": "array",
                "items": {
                  "type": "object"
                }
              }
            },
            "example": {
              "batch_total_count": 2,
              "batch_success_count": 2,
              "batch_error_count": 0,
              "errors": []
            }
          },
          "404Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "message": {
                "type": "string"
              }
            },
            "example": {
              "code": 404,
              "massage": "Not found"
            }
          },
          "401Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "message": {
                "type": "string"
              }
            },
            "example": {
              "code": 401,
              "massage": "Unauthorized"
            }
          },
          "403Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "data": {
                "type": "array",
                "items": {
                  "type": "string"
                }
              }
            },
            "example": {
              "code": 403,
              "massage": "Access denied or quota limit exceeded"
            }
          },
          "blogpostsWithoutInternal": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#\/components\/schemas\/AbstractContentTypeSchemaDefinitionWithoutInternal"
              },
              {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string",
                    "description": ""
                  },
                  "postContent": {
                    "type": "string",
                    "description": ""
                  }
                }
              }
            ],
            "additionalProperties": false,
            "example": {
              "id": "blogposts-1",
              "title": "title",
              "postContent": "postContent"
            }
          },
          "blogposts": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#\/components\/schemas\/AbstractContentTypeSchemaDefinition"
              },
              {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string",
                    "description": ""
                  },
                  "postContent": {
                    "type": "string",
                    "description": ""
                  }
                }
              }
            ],
            "additionalProperties": false,
            "example": {
              "id": "blogposts-1",
              "internal": {
                "contentType": "blogposts",
                "createdAt": "2021-04-20T07:46:17+00:00",
                "updatedAt": "2021-04-20T07:46:17+00:00",
                "deletedAt": ""
              },
              "title": "title",
              "postContent": "postContent"
            }
          },
          "blogpostsList": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#/components/schemas/SystemListProperties"
              },
              {
                "properties": {
                  "data": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              }
            ]
          },
          "_mediaWithoutInternal": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#\/components\/schemas\/AbstractContentTypeSchemaDefinitionWithoutInternal"
              },
              {
                "type": "object",
                "properties": {
                  "url": {
                    "type": "string",
                    "minLength": 1
                  },
                  "size": {
                    "type": "number",
                    "minLength": 1
                  },
                  "type": {
                    "type": "string",
                    "minLength": 1
                  },
                  "width": {
                    "type": "number"
                  },
                  "height": {
                    "type": "number"
                  },
                  "source": {
                    "type": "string",
                    "minLength": 1
                  },
                  "fileName": {
                    "type": "string",
                    "minLength": 1
                  },
                  "mimeType": {
                    "type": "string",
                    "minLength": 1
                  },
                  "extension": {
                    "type": "string",
                    "minLength": 1
                  },
                  "externalId": {
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
            "additionalProperties": false,
            "example": {
              "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
              "extension": "png",
              "fileName": "example_image.png",
              "mimeType": "image\/png",
              "size": 87258,
              "type": "image",
              "source": "disk",
              "externalId": "",
              "url": "\/image\/0x0\/_media-698d20aa-193a-47b3-be4d-550c1aab47e7.png",
              "height": 517,
              "width": 925
            }
          },
          "_media": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#\/components\/schemas\/AbstractContentTypeSchemaDefinition"
              },
              {
                "type": "object",
                "properties": {
                  "url": {
                    "type": "string",
                    "minLength": 1
                  },
                  "size": {
                    "type": "number",
                    "minLength": 1
                  },
                  "type": {
                    "type": "string",
                    "minLength": 1
                  },
                  "width": {
                    "type": "number"
                  },
                  "height": {
                    "type": "number"
                  },
                  "source": {
                    "type": "string",
                    "minLength": 1
                  },
                  "fileName": {
                    "type": "string",
                    "minLength": 1
                  },
                  "mimeType": {
                    "type": "string",
                    "minLength": 1
                  },
                  "extension": {
                    "type": "string",
                    "minLength": 1
                  },
                  "externalId": {
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
            "additionalProperties": false,
            "example": {
              "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
              "extension": "png",
              "fileName": "example_image.png",
              "mimeType": "image\/png",
              "size": 87258,
              "type": "image",
              "source": "disk",
              "externalId": "",
              "url": "\/image\/0x0\/_media-698d20aa-193a-47b3-be4d-550c1aab47e7.png",
              "height": 517,
              "width": 925,
              "internal": {
                "contentType": "_media",
                "createdAt": "2021-04-20T07:46:17+00:00",
                "updatedAt": "2021-04-20T07:46:17+00:00",
                "deletedAt": ""
              }
            }
          },
          "_mediaList": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#/components/schemas/SystemListProperties"
              },
              {
                "properties": {
                  "data": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/_media"
                    }
                  }
                }
              }
            ]
          }
        }
      },
      "paths": {
        "/api/v1/content/blogposts": {
          "post": {
            "operationId": "createBlogposts",
            "description": "Allows you to create object of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FcreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/blogpostsWithoutInternal"
                  },
                  "example": {
                    "id": "blogposts-1",
                    "title": "title",
                    "postContent": "postContent"
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "id": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "id": [
                          "This value is already used"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          },
          "get": {
            "operationId": "listBlogposts",
            "description": "List objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FlistBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "schema": {
                  "type": "number",
                  "default": 1,
                  "minimum": 1,
                  "example": 1
                }
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "schema": {
                  "type": "number",
                  "default": 20,
                  "minimum": 1,
                  "example": 20
                }
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "schema": {
                  "type": "string",
                  "default": "internal.createdAt",
                  "example": "internal.createdAt"
                },
                "example": "internal.updatedAt"
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "schema": {
                  "type": "string",
                  "default": "asc",
                  "example": "asc"
                }
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "schema": {
                  "type": "number",
                  "minimum": 0,
                  "maximum": 1,
                  "default": 0,
                  "example": 0
                }
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "List filters",
                "schema": {
                  "type": "string",
                  "default": "{}",
                  "example": "{}"
                },
                "example": "{\"slug\":{\"type\":\"contains\",\"filter\":\"test\"},\"title\":{\"type\":\"contains\",\"filter\":\"test\"}}"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogpostsList"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "filters": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "filters": [
                          "Malformed filters json - Syntax error"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/batch": {
          "post": {
            "operationId": "batchCreateBlogposts",
            "description": "Allows you to create or create and update up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FbatchCreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "updateExisting",
                "required": false,
                "description": "Overwrite existing objects",
                "schema": {
                  "type": "boolean",
                  "default": false
                }
              }
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/blogpostsWithoutInternal"
                    }
                  },
                  "example": [
                    {
                      "id": "blogposts-1",
                      "title": "title",
                      "postContent": "postContent"
                    },
                    {
                      "id": "blogposts-2",
                      "title": "title",
                      "postContent": "postContent"
                    }
                  ]
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/BatchResponseSuccess"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/BatchResponseError"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/removed": {
          "get": {
            "operationId": "getRemovedBlogposts",
            "description": "Get ids of removed Blog posts objects. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FgetRemovedBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "deletedAfter",
                "required": false,
                "description": "Date from which ids of removed objects should be returned",
                "schema": {
                  "type": "string"
                },
                "example": "2020-01-01 12:00:00"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      },
                      "example": [
                        "blogposts-1"
                      ]
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "deletedAfter": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "deletedAfter": [
                          "Wrong date format"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/batch-delete": {
          "post": {
            "operationId": "batchDeleteBlogposts",
            "description": "Allows you to dlete up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FbatchDeleteBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  },
                  "example": [
                    "blogposts-1",
                    "blogposts-2"
                  ]
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "deletedCount": {
                          "type": "number"
                        }
                      },
                      "example": {
                        "deletedCount": 2
                      }
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "errors": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "errors": [
                          "Content object: \"blogposts-1\" doesn't exist",
                          "Content object: \"blogposts-2\" is used in another content object."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/{id}": {
          "get": {
            "operationId": "getBlogposts",
            "description": "Returns all information about Blog posts object. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FgetBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "blogposts-1"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "schema": {
                  "type": "number",
                  "minimum": 0,
                  "maximum": 1,
                  "default": 0
                }
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          },
          "put": {
            "operationId": "updateBlogposts",
            "description": "Allows update of the Blog posts object, it has to have all fields, as this operation overwrites the object. All properties  not included in the payload will be lost. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FupdateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "blogposts-1"
              }
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/blogpostsWithoutInternal"
                  },
                  "example": {
                    "id": "blogposts-1",
                    "title": "title",
                    "postContent": "postContent"
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "id": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "id": [
                          "This value is already used"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          },
          "delete": {
            "operationId": "deleteBlogposts",
            "description": "Removes Blog posts object.<br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FdeleteBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "blogposts-1"
              }
            ],
            "responses": {
              "204": {
                "description": "OK"
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "errors": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "errors": [
                          "This content object is used in another content object."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/_media": {
          "post": {
            "operationId": "create_media",
            "description": "Allows you to create object of Media type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Fcreate_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/_mediaWithoutInternal"
                  },
                  "example": {
                    "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
                    "extension": "png",
                    "fileName": "example_image.png",
                    "mimeType": "image\/png",
                    "size": 87258,
                    "type": "image",
                    "source": "disk",
                    "externalId": "",
                    "url": "\/image\/0x0\/_media-698d20aa-193a-47b3-be4d-550c1aab47e7.png",
                    "height": 517,
                    "width": 925
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/_media"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "fileName": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "mimeType": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "size": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "url": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "source": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "extension": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "type": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "id": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "width": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "height": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "id": [
                          "This value is already used"
                        ],
                        "fileName": [
                          "The property fileName is required",
                          "Must be at least 1 characters long"
                        ],
                        "mimeType": [
                          "The property mimeType is required",
                          "Must be at least 1 characters long"
                        ],
                        "size": [
                          "The property size is required",
                          "String value found, but a number is required"
                        ],
                        "url": [
                          "The property url is required",
                          "Must be at least 1 characters long"
                        ],
                        "source": [
                          "The property source is required",
                          "Must be at least 1 characters long",
                          "The value does not match possible options"
                        ],
                        "extension": [
                          "The property extension is required",
                          "Must be at least 1 characters long"
                        ],
                        "type": [
                          "The property type is required",
                          "Must be at least 1 characters long",
                          "The value does not match possible options"
                        ],
                        "width": [
                          "String value found, but a number is required"
                        ],
                        "height": [
                          "String value found, but a number is required"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          },
          "get": {
            "operationId": "list_media",
            "description": "List objects of Media type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Flist_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "schema": {
                  "type": "number",
                  "default": 1,
                  "minimum": 1,
                  "example": 1
                }
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "schema": {
                  "type": "number",
                  "default": 20,
                  "minimum": 1,
                  "example": 20
                }
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "schema": {
                  "type": "string",
                  "default": "internal.createdAt",
                  "example": "internal.createdAt"
                },
                "example": "internal.updatedAt"
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "schema": {
                  "type": "string",
                  "default": "asc",
                  "example": "asc"
                }
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "schema": {
                  "type": "number",
                  "minimum": 0,
                  "maximum": 1,
                  "default": 0,
                  "example": 0
                }
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "List filters",
                "schema": {
                  "type": "string",
                  "default": "{}",
                  "example": "{}"
                },
                "example": "{\"slug\":{\"type\":\"contains\",\"filter\":\"test\"},\"title\":{\"type\":\"contains\",\"filter\":\"test\"}}"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/_mediaList"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "filters": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "filters": [
                          "Malformed filters json - Syntax error"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/_media/batch": {
          "post": {
            "operationId": "batchCreate_media",
            "description": "Allows you to create or create and update up to 100 objects of Media type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2FbatchCreate_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "updateExisting",
                "required": false,
                "description": "Overwrite existing objects",
                "schema": {
                  "type": "boolean",
                  "default": false
                }
              }
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/_mediaWithoutInternal"
                    }
                  },
                  "example": [
                    {
                      "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
                      "extension": "png",
                      "fileName": "example_image.png",
                      "mimeType": "image\/png",
                      "size": 87258,
                      "type": "image",
                      "source": "disk",
                      "externalId": "",
                      "url": "\/image\/0x0\/_media-698d20aa-193a-47b3-be4d-550c1aab47e7.png",
                      "height": 517,
                      "width": 925
                    },
                    {
                      "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
                      "extension": "png",
                      "fileName": "example_image.png",
                      "mimeType": "image\/png",
                      "size": 87258,
                      "type": "image",
                      "source": "disk",
                      "externalId": "",
                      "url": "\/image\/0x0\/_media-698d20aa-193a-47b3-be4d-550c1aab47e7.png",
                      "height": 517,
                      "width": 925
                    }
                  ]
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/BatchResponseSuccess"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/BatchResponseError"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/_media/removed": {
          "get": {
            "operationId": "getRemoved_media",
            "description": "Get ids of removed Media objects. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2FgetRemoved_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "deletedAfter",
                "required": false,
                "description": "Date from which ids of removed objects should be returned",
                "schema": {
                  "type": "string"
                },
                "example": "2020-01-01 12:00:00"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      },
                      "example": [
                        "_media-1"
                      ]
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "deletedAfter": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "deletedAfter": [
                          "Wrong date format"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/_media/batch-delete": {
          "post": {
            "operationId": "batchDelete_media",
            "description": "Allows you to dlete up to 100 objects of Media type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2FbatchDelete_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  },
                  "example": [
                    "_media-1",
                    "_media-2"
                  ]
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "deletedCount": {
                          "type": "number"
                        }
                      },
                      "example": {
                        "deletedCount": 2
                      }
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "errors": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "errors": [
                          "Content object: \"_media-1\" doesn't exist",
                          "Content object: \"_media-2\" is used in another content object."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/_media/{id}": {
          "get": {
            "operationId": "get_media",
            "description": "Returns all information about Media object. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Fget_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "_media-1"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "schema": {
                  "type": "number",
                  "minimum": 0,
                  "maximum": 1,
                  "default": 0
                }
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/_media"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          },
          "put": {
            "operationId": "update_media",
            "description": "Allows update of the Media object, it has to have all fields, as this operation overwrites the object. All properties  not included in the payload will be lost. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Fupdate_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "_media-1"
              }
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/_mediaWithoutInternal"
                  },
                  "example": {
                    "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
                    "extension": "png",
                    "fileName": "example_image.png",
                    "mimeType": "image\/png",
                    "size": 87258,
                    "type": "image",
                    "source": "disk",
                    "externalId": "",
                    "url": "\/image\/0x0\/_media-698d20aa-193a-47b3-be4d-550c1aab47e7.png",
                    "height": 517,
                    "width": 925
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/_media"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "fileName": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "mimeType": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "size": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "url": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "source": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "extension": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "type": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "id": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "width": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "height": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "id": [
                          "This value is already used"
                        ],
                        "fileName": [
                          "The property fileName is required",
                          "Must be at least 1 characters long"
                        ],
                        "mimeType": [
                          "The property mimeType is required",
                          "Must be at least 1 characters long"
                        ],
                        "size": [
                          "The property size is required",
                          "String value found, but a number is required"
                        ],
                        "url": [
                          "The property url is required",
                          "Must be at least 1 characters long"
                        ],
                        "source": [
                          "The property source is required",
                          "Must be at least 1 characters long",
                          "The value does not match possible options"
                        ],
                        "extension": [
                          "The property extension is required",
                          "Must be at least 1 characters long"
                        ],
                        "type": [
                          "The property type is required",
                          "Must be at least 1 characters long",
                          "The value does not match possible options"
                        ],
                        "width": [
                          "String value found, but a number is required"
                        ],
                        "height": [
                          "String value found, but a number is required"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          },
          "delete": {
            "operationId": "delete_media",
            "description": "Removes Media object.<br /><a target='_blank' href='https://apidoc.flotiq.com/?url=https%3A%2F%2Fapi.flotiq.com%2api%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Fdelete_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "_media-1"
              }
            ],
            "responses": {
              "204": {
                "description": "OK"
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "errors": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "errors": [
                          "This content object is used in another content object."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/internal/contenttype": {
          "get": {
            "operationId": "getContentDefinitions",
            "description": "Returns an array of user-defined Content Definitions",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "schema": {
                  "type": "number",
                  "default": 1,
                  "minimum": 1,
                  "example": 1
                }
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "schema": {
                  "type": "number",
                  "default": 20,
                  "minimum": 1,
                  "example": 20
                }
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "schema": {
                  "type": "string",
                  "default": "name",
                  "example": "name"
                },
                "example": "name"
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "schema": {
                  "type": "string",
                  "default": "asc",
                  "example": "asc"
                }
              },
              {
                "in": "query",
                "name": "name",
                "required": false,
                "description": "Filters CTDs by name",
                "schema": {
                  "type": "string",
                  "default": "",
                  "example": ""
                },
                "example": "_media"
              },
              {
                "in": "query",
                "name": "label",
                "required": false,
                "description": "Filters CTDs by label",
                "schema": {
                  "type": "string",
                  "default": "",
                  "example": ""
                },
                "example": "Media"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/ContentTypeListResponse"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          },
          "post": {
            "operationId": "postContentDefinition",
            "description": "Create new ContentTypeDefinition to store new type of ContentObjects",
            "tags": [
              "Internal"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/ContentTypeDefinitionSchema"
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/ContentTypeDefinitionSchema"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "label": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "schemaDefinition.allOf[1].properties.title.type": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "metaDefinition.propertiesConfig.price.label": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "metaDefinition.propertiesConfig.price.inputType": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
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
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/internal/contenttype/{id}": {
          "get": {
            "operationId": "getContentDefinition",
            "description": "Returns an user-defined Content Definitions",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "Id of content type definition",
                "schema": {
                  "type": "string"
                },
                "example": "_media"
              },
              {
                "in": "query",
                "name": "resolveRef",
                "required": false,
                "description": "Should the system resolve references done using $ref",
                "schema": {
                  "type": "boolean",
                  "default": false
                },
                "example": false
              },
              {
                "in": "query",
                "name": "strictSchema",
                "required": false,
                "description": "Use 'schema' instead of 'schemaDefinition'",
                "schema": {
                  "type": "boolean",
                  "default": false
                },
                "example": false
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/ContentTypeDefinitionSchema"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          },
          "put": {
            "operationId": "putContentDefinition",
            "description": "Update ConentTypeDefinition",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "Id of content type definition",
                "schema": {
                  "type": "string"
                },
                "example": "products"
              }
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/ContentTypeDefinitionSchema"
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/ContentTypeDefinitionSchema"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "label": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "schemaDefinition.allOf[1].properties.title.type": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "metaDefinition.propertiesConfig.price.label": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "metaDefinition.propertiesConfig.price.inputType": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
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
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          },
          "delete": {
            "operationId": "deleteContentDefinition",
            "description": "Delete ContentTypeDefinition",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "Id of content type definition",
                "schema": {
                  "type": "string"
                },
                "example": "product"
              }
            ],
            "responses": {
              "200": {
                "description": "OK"
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "errors": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      }
                    },
                    "example": {
                      "errors": [
                        "This content type definition is used by Api Key: New key",
                        "Content Type has objects, you can't remove it!"
                      ]
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/search": {
          "get": {
            "operationId": "search",
            "description": "The Flotiq API provides a powerful search engine, which is a wrapper for ElasticSearch queries. We tried to balance between resembling the ES API (for those, who already know it) and keeping it simple and cohesive with Flotiq API. This endpoint provides means for querying content objects that match a set of criteria, with options for:\n\n * limiting search to specific Content Types,\n * limit search to specific fields,\n * weighting fields to modify results scoring,\n * aggregating results by fields.\n\n You can find more information about the Search API in the [Search API docs](https://flotiq.com/docs/API/search/).",
            "tags": [
              "Search API"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "q",
                "required": false,
                "description": "Query",
                "schema": {
                  "type": "string",
                  "default": ""
                }
              },
              {
                "in": "query",
                "name": "fields[]",
                "required": false,
                "description": "Search only in selected fields.",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              },
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "schema": {
                  "type": "string",
                  "default": "1"
                }
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "schema": {
                  "type": "string",
                  "default": "20"
                }
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "schema": {
                  "type": "string",
                  "default": ""
                }
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "schema": {
                  "type": "string",
                  "default": "asc"
                }
              },
              {
                "in": "query",
                "name": "content_type[]",
                "required": false,
                "description": "Restrict search to content types set",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              },
              {
                "in": "query",
                "name": "aggregate_by[]",
                "required": false,
                "description": "Field to aggregate results direction (string fields only)",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              },
              {
                "in": "query",
                "name": "aggregate_by_numeric[]",
                "required": false,
                "description": "Field to aggregate results direction with numeric type",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "Filter by object properties. Expected format: filters[property1]=value1&filters[property2]=value2",
                "schema": {
                  "type": "object"
                },
                "style": "deepObject",
                "example": {
                  "public": true
                }
              },
              {
                "in": "query",
                "name": "post_filters",
                "required": false,
                "description": "Filter by object properties. Use it when you want aggregated counts without filters applied. Expected format: post_filters[property1]=value1&post_filters[property2]=value2",
                "schema": {
                  "type": "object"
                },
                "style": "deepObject",
                "example": {
                  "public": true
                }
              },
              {
                "in": "query",
                "name": "geo_filters",
                "required": false,
                "description": "Filter by object geolocation properties. Example value: geo_filters[location]=geo_distance,1.50km,40.1,-19.2 (filter name, distance, latitude, longitude). For more information see ElasticSearch docs. Only geo_distance query is supported.",
                "schema": {
                  "type": "object"
                },
                "style": "deepObject",
                "example": {
                  "location": "geo_distance,1.50km,40.1,-19.2"
                }
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/SearchResponse"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "geo_filters": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "geo_filters": [
                          "Invalid geo filter query provided. Example value is: 'geo_distance,1.50km,40.1,-19.2'. Accepted filter types are: 'geo_distance'."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/graphql": {
          "post": {
            "operationId": "graphQL",
            "description": "Endpoint for GraphQL Queries for Headless Types",
            "tags": [
              "GraphQL"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "object",
                    "properties": {
                      "query": {
                        "type": "string",
                        "format": "text",
                        "description": "Graph QL query, for example: query{productsList{id,name}}",
                        "example": "query{_mediaList{id,extension}}"
                      }
                    },
                    "required": [
                      "query"
                    ]
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "example": {
                        "data": {
                          "_mediaList": [
                            {
                              "id": "_media-92328709-64b8-4479-bf00-6e24b7869bb7",
                              "extension": "png"
                            },
                            {
                              "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
                              "extension": "png"
                            },
                            {
                              "id": "_media-21d1beba-48d0-46fa-9bac-55c2afa561a7",
                              "extension": "png"
                            }
                          ]
                        }
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/graphql/schema": {
          "get": {
            "operationId": "graphQLSchema",
            "description": "Get current descripion of GraphQL Schema",
            "tags": [
              "GraphQL"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "text/html": {
                    "example": "type Query {\n_media(id: String!): _media\n  _mediaList(page: Int, limit: Int, order_by: String, order_direction: String): [_media]\n}\n\n\"\"\"Auto generated Headless CMS type: _media\"\"\"\ntype _media {\n  id: String\n  url: String\n  size: Float\n  type: String\n  width: Float\n  height: Float\n  source: String\n  fileName: String\n  mimeType: String\n  extension: String\n  externalId: String\n}"
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/media": {
          "post": {
            "operationId": "postMedia",
            "description": "Endpoint for media files upload",
            "tags": [
              "Media"
            ],
            "requestBody": {
              "content": {
                "multipart/form-data": {
                  "schema": {
                    "type": "object",
                    "properties": {
                      "file": {
                        "type": "string",
                        "format": "binary",
                        "description": "File to upload"
                      },
                      "type": {
                        "type": "string",
                        "description": "Type of file image|file",
                        "enum": [
                          "image",
                          "file"
                        ],
                        "example": "image"
                      },
                      "save": {
                        "type": "number",
                        "description": "Should file be saved to database on upload: 0|1",
                        "default": 0,
                        "example": 1
                      }
                    },
                    "required": [
                      "file",
                      "type"
                    ]
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/_mediaWithoutInternal"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "file": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "file": [
                          "The mime type of the file is invalid (\"application/gzip\"). Allowed mime types are \"image/gif\", \"image/png\", \"image/jpeg\", \"image/bmp\", \"image/webp\", \"image/svg+xml\", \"image/svg\", \"image/x-icon\", \"image/vnd.microsoft.icon\", \"text/plain\", \"audio/midi\", \"audio/mpeg\", \"audio/webm\", \"audio/ogg\", \"audio/wav\", \"video/webm\", \"video/ogg\", \"video/mp4\", \"application/pdf\", \"application/json\".",
                          "The file is too large (26.17 MB). Allowed maximum size is 10 MB."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/image/{width_height}/{key}": {
          "get": {
            "operationId": "getMedia",
            "description": "Get single media file",
            "tags": [
              "Media"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "width_height",
                "required": true,
                "description": "Expected format: WIDTHxHEIGHT, for example 750x200. Width of the image, or 0 when the file is not an image or it should have original uploaded width, or it should be scaled proportionally with height specified. Height of the image, or 0 when the file is not an image or it should have original uploaded height, or it should be scaled proportionally with width specified",
                "schema": {
                  "type": "string",
                  "default": "0x0"
                }
              },
              {
                "in": "path",
                "name": "key",
                "required": true,
                "description": "Key of the file, it is made from id and extension, e.g. _media-4564.jpg for image with id _media-4564 and jpg extension",
                "schema": {
                  "type": "string"
                },
                "example": "_media-4564.jpg"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "image/jpeg": {
                    "schema": {
                      "type": "string",
                      "format": "binary"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    ```

??? "Response for user only version 3"

    Example curl request
    ```
    curl -X GET "https://api.flotiq.com/api/v1/open-api-schema.json?user_only=true" \
         -H 'accept: */*' \
         -H 'X-AUTH-TOKEN: YOUR_API_KEY' \
         -H 'Content-Type: application/json'
    ```

    Response
    
    ```
    {
      "openapi": "3.0.0",
      "info": {
        "description": "## Getting started\n\n This is your Flotiq User API that allows you to access your data through the Content API that you defined.\n\n ### Access to data\n\n There are several methods that you can use to access your data:\n * Live API docs - available via <code>Try it out</code> button available next to each endpoint \n * Copying example code on the right side of each endpoint\n * By downloading the SDKs available in mulitple languages.\n * By downloading the Postman collection and importing it into Postman.\n\n\n Each of these methods is described in length in the [user documentation](https://flotiq.com/docs/).\n\n ### Authorization\n\n In order to make use of the provided documentation, example code, SDKs and so on - you will need to pull out your API key. We recommend that you start with the ReadOnly API Key which will allow you to make all the `GET` requests but will error-out when you try to modify content. Please remember to replace the key for `POST`, `PUT` and `DELETE` calls.\n\n It's also possible to use scoped API keys - you can create those in the API keys section of the Flotiq user interface. This will allow you to create a key that only authorizes access to a specific content type (or a set of content types, if you choose so). Read more about how to use and create API keys in the [API keys documentation](https://flotiq.com/docs/API/).\n\n ## Object access\n\n Once you define a Content Type it will become available in your Content API as a set of endpoints that will allow you to work with objects:\n\n * create\n * list\n * update\n * delete\n * batch create\n * retrieve single object.\n\n### Hydration\n\n When you build Content Types that have relation to others your objects will optionally support hydration of related entities. The endpoints that support object retrieval accept a `hydrate` parameter, which can be used to easily fetch hydrated objects. Since this breaks the standard REST concepts - it's not enabled by default, but it's a very handy feature that allows to reduce the amount of HTTP requests sent over the wire and we strongly recommend to use it.",
        "title": "Flotiq User API",
        "version": "2.0.1",
        "contact": {
          "name": "Flotiq Developers",
          "email": "hello@flotiq.com",
          "url": "https://flotiq.com"
        },
        "x-logo": {
          "url": "https://editor.flotiq.com/fonts/fq-logo.svg",
          "altText": "Flotiq User API"
        }
      },
      "x-tagGroups": [
        {
          "name": "User API",
          "tags": [
            "Content: Blog posts"
          ]
        }
      ],
      "servers": [
        {
          "url": "http://localhost:8069",
          "description": "Flotiq Live"
        }
      ],
      "security": [
        {
          "HeaderApiKeyAuth": []
        }
      ],
      "components": {
        "securitySchemes": {
          "HeaderApiKeyAuth": {
            "description": "Personal Auth token generated for user in Headless CMS application",
            "type": "apiKey",
            "in": "header",
            "name": "X-AUTH-TOKEN"
          }
        },
        "schemas": {
          "AbstractContentTypeSchemaDefinition": {
            "type": "object",
            "properties": {
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
              "id"
            ]
          },
          "AbstractContentTypeSchemaDefinitionWithoutInternal": {
            "type": "object",
            "properties": {
              "id": {
                "type": "string",
                "description": "Unique ID of the object"
              }
            },
            "required": [
              "id"
            ]
          },
          "DataSource": {
            "type": "object",
            "description": "Represents link between data stored internally inside CMS or external",
            "additionalProperties": false,
            "properties": {
              "dataUrl": {
                "type": "string"
              },
              "type": {
                "type": "string",
                "enum": [
                  "internal",
                  "external"
                ],
                "default": "internal"
              }
            },
            "required": [
              "dataUrl",
              "type"
            ]
          },
          "SystemListProperties": {
            "type": "object",
            "additionalProperties": false,
            "required": [
              "total_count",
              "count",
              "total_pages",
              "current_page"
            ],
            "properties": {
              "total_count": {
                "type": "number",
                "example": 1
              },
              "count": {
                "type": "number",
                "example": 1
              },
              "total_pages": {
                "type": "number",
                "example": 1
              },
              "current_page": {
                "type": "number",
                "example": 1
              }
            }
          },
          "BatchResponseError": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
              "batch_total_count": {
                "type": "number"
              },
              "batch_success_count": {
                "type": "number"
              },
              "batch_error_count": {
                "type": "number"
              },
              "errors": {
                "type": "array",
                "items": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "string"
                    },
                    "errors": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      }
                    }
                  }
                }
              }
            },
            "example": {
              "batch_total_count": 2,
              "batch_success_count": 0,
              "batch_error_count": 2,
              "errors": [
                {
                  "id": "test-1",
                  "errors": {
                    "name": [
                      "The property name is required"
                    ]
                  }
                },
                {
                  "id": "test-2",
                  "errors": {
                    "name": [
                      "The property name is required"
                    ]
                  }
                }
              ]
            }
          },
          "BatchResponseSuccess": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
              "batch_total_count": {
                "type": "number"
              },
              "batch_success_count": {
                "type": "number"
              },
              "batch_error_count": {
                "type": "number"
              },
              "errors": {
                "type": "array",
                "items": {
                  "type": "object"
                }
              }
            },
            "example": {
              "batch_total_count": 2,
              "batch_success_count": 2,
              "batch_error_count": 0,
              "errors": []
            }
          },
          "404Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "message": {
                "type": "string"
              }
            },
            "example": {
              "code": 404,
              "massage": "Not found"
            }
          },
          "401Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "message": {
                "type": "string"
              }
            },
            "example": {
              "code": 401,
              "massage": "Unauthorized"
            }
          },
          "403Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "data": {
                "type": "array",
                "items": {
                  "type": "string"
                }
              }
            },
            "example": {
              "code": 403,
              "massage": "Access denied or quota limit exceeded"
            }
          },
          "blogpostsWithoutInternal": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#\/components\/schemas\/AbstractContentTypeSchemaDefinitionWithoutInternal"
              },
              {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string",
                    "description": ""
                  },
                  "postContent": {
                    "type": "string",
                    "description": ""
                  }
                }
              }
            ],
            "additionalProperties": false,
            "example": {
              "id": "blogposts-1",
              "title": "title",
              "postContent": "postContent"
            }
          },
          "blogposts": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#\/components\/schemas\/AbstractContentTypeSchemaDefinition"
              },
              {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string",
                    "description": ""
                  },
                  "postContent": {
                    "type": "string",
                    "description": ""
                  }
                }
              }
            ],
            "additionalProperties": false,
            "example": {
              "id": "blogposts-1",
              "internal": {
                "contentType": "blogposts",
                "createdAt": "2021-04-20T08:10:35+00:00",
                "updatedAt": "2021-04-20T08:10:35+00:00",
                "deletedAt": ""
              },
              "title": "title",
              "postContent": "postContent"
            }
          },
          "blogpostsList": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#/components/schemas/SystemListProperties"
              },
              {
                "properties": {
                  "data": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              }
            ]
          }
        }
      },
      "paths": {
        "/api/v1/content/blogposts": {
          "post": {
            "operationId": "createBlogposts",
            "description": "Allows you to create object of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FcreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/blogpostsWithoutInternal"
                  },
                  "example": {
                    "id": "blogposts-1",
                    "title": "title",
                    "postContent": "postContent"
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "id": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "id": [
                          "This value is already used"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          },
          "get": {
            "operationId": "listBlogposts",
            "description": "List objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FlistBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "schema": {
                  "type": "number",
                  "default": 1,
                  "minimum": 1,
                  "example": 1
                }
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "schema": {
                  "type": "number",
                  "default": 20,
                  "minimum": 1,
                  "example": 20
                }
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "schema": {
                  "type": "string",
                  "default": "internal.createdAt",
                  "example": "internal.createdAt"
                },
                "example": "internal.updatedAt"
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "schema": {
                  "type": "string",
                  "default": "asc",
                  "example": "asc"
                }
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "schema": {
                  "type": "number",
                  "minimum": 0,
                  "maximum": 1,
                  "default": 0,
                  "example": 0
                }
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "List filters",
                "schema": {
                  "type": "string",
                  "default": "{}",
                  "example": "{}"
                },
                "example": "{\"slug\":{\"type\":\"contains\",\"filter\":\"test\"},\"title\":{\"type\":\"contains\",\"filter\":\"test\"}}"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogpostsList"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "filters": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "filters": [
                          "Malformed filters json - Syntax error"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/batch": {
          "post": {
            "operationId": "batchCreateBlogposts",
            "description": "Allows you to create or create and update up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FbatchCreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "updateExisting",
                "required": false,
                "description": "Overwrite existing objects",
                "schema": {
                  "type": "boolean",
                  "default": false
                }
              }
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/blogpostsWithoutInternal"
                    }
                  },
                  "example": [
                    {
                      "id": "blogposts-1",
                      "title": "title",
                      "postContent": "postContent"
                    },
                    {
                      "id": "blogposts-2",
                      "title": "title",
                      "postContent": "postContent"
                    }
                  ]
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/BatchResponseSuccess"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/BatchResponseError"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/removed": {
          "get": {
            "operationId": "getRemovedBlogposts",
            "description": "Get ids of removed Blog posts objects. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FgetRemovedBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "deletedAfter",
                "required": false,
                "description": "Date from which ids of removed objects should be returned",
                "schema": {
                  "type": "string"
                },
                "example": "2020-01-01 12:00:00"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      },
                      "example": [
                        "blogposts-1"
                      ]
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "deletedAfter": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "deletedAfter": [
                          "Wrong date format"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/batch-delete": {
          "post": {
            "operationId": "batchDeleteBlogposts",
            "description": "Allows you to dlete up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FbatchDeleteBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "array",
                    "items": {
                      "type": "string"
                    }
                  },
                  "example": [
                    "blogposts-1",
                    "blogposts-2"
                  ]
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "deletedCount": {
                          "type": "number"
                        }
                      },
                      "example": {
                        "deletedCount": 2
                      }
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "errors": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "errors": [
                          "Content object: \"blogposts-1\" doesn't exist",
                          "Content object: \"blogposts-2\" is used in another content object."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/{id}": {
          "get": {
            "operationId": "getBlogposts",
            "description": "Returns all information about Blog posts object. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FgetBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "blogposts-1"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "schema": {
                  "type": "number",
                  "minimum": 0,
                  "maximum": 1,
                  "default": 0
                }
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          },
          "put": {
            "operationId": "updateBlogposts",
            "description": "Allows update of the Blog posts object, it has to have all fields, as this operation overwrites the object. All properties  not included in the payload will be lost. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FupdateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "blogposts-1"
              }
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/blogpostsWithoutInternal"
                  },
                  "example": {
                    "id": "blogposts-1",
                    "title": "title",
                    "postContent": "postContent"
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "id": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "id": [
                          "This value is already used"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          },
          "delete": {
            "operationId": "deleteBlogposts",
            "description": "Removes Blog posts object.<br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FdeleteBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "schema": {
                  "type": "string"
                },
                "example": "blogposts-1"
              }
            ],
            "responses": {
              "204": {
                "description": "OK"
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "errors": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "errors": [
                          "This content object is used in another content object."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    ```

??? "Response for full version 2"

    Example curl request
    ```
    curl -X GET "https://api.flotiq.com/api/v1/open-api-schema.json?version=2" \
         -H 'accept: */*' \
         -H 'X-AUTH-TOKEN: YOUR_API_KEY' \
         -H 'Content-Type: application/json'
    ```

    Response
    ```
    {
      "swagger": "2.0",
      "info": {
        "description": "## Getting started\n\n This is your Flotiq User API that allows you to access your data through the Content API that you defined.\n\n ### Access to data\n\n There are several methods that you can use to access your data:\n * Live API docs - available via <code>Try it out</code> button available next to each endpoint \n * Copying example code on the right side of each endpoint\n * By downloading the SDKs available in mulitple languages.\n * By downloading the Postman collection and importing it into Postman.\n\n\n Each of these methods is described in length in the [user documentation](https://flotiq.com/docs/).\n\n ### Authorization\n\n In order to make use of the provided documentation, example code, SDKs and so on - you will need to pull out your API key. We recommend that you start with the ReadOnly API Key which will allow you to make all the `GET` requests but will error-out when you try to modify content. Please remember to replace the key for `POST`, `PUT` and `DELETE` calls.\n\n It's also possible to use scoped API keys - you can create those in the API keys section of the Flotiq user interface. This will allow you to create a key that only authorizes access to a specific content type (or a set of content types, if you choose so). Read more about how to use and create API keys in the [API keys documentation](https://flotiq.com/docs/API/).\n\n ## Object access\n\n Once you define a Content Type it will become available in your Content API as a set of endpoints that will allow you to work with objects:\n\n * create\n * list\n * update\n * delete\n * batch create\n * retrieve single object.\n\n### Hydration\n\n When you build Content Types that have relation to others your objects will optionally support hydration of related entities. The endpoints that support object retrieval accept a `hydrate` parameter, which can be used to easily fetch hydrated objects. Since this breaks the standard REST concepts - it's not enabled by default, but it's a very handy feature that allows to reduce the amount of HTTP requests sent over the wire and we strongly recommend to use it.",
        "title": "Flotiq User API",
        "version": "2.0.1",
        "contact": {
          "name": "Flotiq Developers",
          "email": "hello@flotiq.com",
          "url": "https://flotiq.com"
        },
        "x-logo": {
          "url": "https://editor.flotiq.com/fonts/fq-logo.svg",
          "altText": "Flotiq User API"
        }
      },
      "x-tagGroups": [
        {
          "name": "User API",
          "tags": [
            "Content: Blog posts",
            "Content: Media"
          ]
        },
        {
          "name": "Flotiq API",
          "tags": [
            "Search API",
            "Internal",
            "Media",
            "GraphQL"
          ]
        }
      ],
      "host": "localhost:8069",
      "schemes": [
        "http"
      ],
      "basePath": "/",
      "security": [
        {
          "HeaderApiKeyAuth": []
        }
      ],
      "securityDefinitions": {
        "HeaderApiKeyAuth": {
          "description": "Personal Auth token generated for user in Headless CMS application",
          "type": "apiKey",
          "in": "header",
          "name": "X-AUTH-TOKEN"
        }
      },
      "definitions": {
        "ContentTypeDefinitionSchema": {
          "type": "object",
          "description": "Representation of content type definition in CMS",
          "properties": {
            "name": {
              "type": "string",
              "minLength": 1
            },
            "label": {
              "type": "string",
              "minLength": 1
            },
            "workflowId": {
              "type": "string"
            },
            "schemaDefinition": {
              "type": "object",
              "description": "JSON Schema object defining structure. Extending AbstractContentTypeSchemaDefinition"
            },
            "metaDefinition": {
              "type": "object",
              "description": "Meta properties for schema definition",
              "$ref": "#/definitions/AbstractContentTypeMetaDefinition"
            },
            "internal": {
              "type": "boolean"
            }
          },
          "required": [
            "name",
            "label",
            "schemaDefinition",
            "metaDefinition"
          ],
          "additionalProperties": false,
          "example": {
            "name": "products",
            "label": "Products",
            "schemaDefinition": {
              "type": "object",
              "allOf": [
                {
                  "$ref": "#/definitions/AbstractContentTypeSchemaDefinition"
                },
                {
                  "type": "object",
                  "properties": {
                    "title": {
                      "type": "string",
                      "minLength": 1
                    }
                  }
                }
              ],
              "required": [
                "title"
              ]
            },
            "metaDefinition": {
              "propertiesConfig": {
                "title": {
                  "inputType": "text",
                  "label": "Title",
                  "unique": true
                }
              },
              "order": [
                "title"
              ]
            }
          }
        },
        "AbstractContentTypeSchemaDefinition": {
          "type": "object",
          "properties": {
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
            "id"
          ]
        },
        "AbstractContentTypeSchemaDefinitionWithoutInternal": {
          "type": "object",
          "properties": {
            "id": {
              "type": "string",
              "description": "Unique ID of the object"
            }
          },
          "required": [
            "id"
          ]
        },
        "AbstractContentTypeMetaDefinition": {
          "type": "object",
          "description": "Meta definition to describe schema - add unique, fields labels",
          "additionalProperties": false,
          "required": [
            "propertiesConfig",
            "order"
          ],
          "properties": {
            "propertiesConfig": {
              "type": "object",
              "additionalProperties": {
                "$ref": "#/definitions/AbstractPropertiesConfig"
              }
            },
            "order": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "uniqueItems": true
            }
          }
        },
        "DataSource": {
          "type": "object",
          "description": "Represents link between data stored internally inside CMS or external",
          "additionalProperties": false,
          "properties": {
            "dataUrl": {
              "type": "string"
            },
            "type": {
              "type": "string",
              "enum": [
                "internal",
                "external"
              ],
              "default": "internal"
            }
          },
          "required": [
            "dataUrl",
            "type"
          ]
        },
        "AbstractPropertiesConfig": {
          "type": "object",
          "additionalProperties": false,
          "required": [
            "label",
            "inputType",
            "unique"
          ],
          "properties": {
            "label": {
              "type": "string"
            },
            "inputType": {
              "type": "string",
              "enum": [
                "text",
                "richtext",
                "textarea",
                "textMarkdown",
                "email",
                "number",
                "radio",
                "checkbox",
                "select",
                "datasource",
                "object",
                "geo"
              ]
            },
            "unique": {
              "type": "boolean"
            },
            "readonly": {
              "type": "boolean"
            },
            "hidden": {
              "type": "boolean"
            },
            "validation": {
              "type": "object",
              "additionalProperties": false,
              "properties": {
                "relationMultiple": {
                  "type": "boolean"
                },
                "relationContenttype": {
                  "type": "string"
                }
              }
            },
            "options": {
              "type": "array",
              "items": {
                "type": "string"
              },
              "uniqueItems": true
            },
            "helpText": {
              "type": "string"
            },
            "isTitlePart": {
              "type": "boolean"
            },
            "items": {
              "type": "object",
              "$ref": "#/definitions/AbstractContentTypeMetaDefinition"
            }
          }
        },
        "SystemListProperties": {
          "type": "object",
          "additionalProperties": false,
          "required": [
            "total_count",
            "count",
            "total_pages",
            "current_page"
          ],
          "properties": {
            "total_count": {
              "type": "number",
              "example": 1
            },
            "count": {
              "type": "number",
              "example": 1
            },
            "total_pages": {
              "type": "number",
              "example": 1
            },
            "current_page": {
              "type": "number",
              "example": 1
            }
          }
        },
        "SearchResponse": {
          "type": "object",
          "additionalProperties": false,
          "allOf": [
            {
              "$ref": "#/definitions/SystemListProperties"
            },
            {
              "properties": {
                "data": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "score": {
                        "type": "number"
                      },
                      "item": {
                        "type": "object",
                        "description": "Source content object stored in Headless CMS"
                      }
                    }
                  }
                },
                "summary": {
                  "type": "object",
                  "properties": {
                    "aggregations": {
                      "type": "object"
                    }
                  }
                }
              },
              "additionalProperties": true
            }
          ]
        },
        "ContentTypeListResponse": {
          "type": "object",
          "additionalProperties": false,
          "allOf": [
            {
              "$ref": "#/definitions/SystemListProperties"
            },
            {
              "properties": {
                "data": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/ContentTypeDefinitionSchema"
                  }
                }
              }
            }
          ]
        },
        "BatchResponseError": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "batch_total_count": {
              "type": "number"
            },
            "batch_success_count": {
              "type": "number"
            },
            "batch_error_count": {
              "type": "number"
            },
            "errors": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "id": {
                    "type": "string"
                  },
                  "errors": {
                    "type": "object",
                    "properties": {
                      "name": {
                        "type": "array",
                        "items": {
                          "type": "string"
                        }
                      }
                    }
                  }
                }
              }
            }
          },
          "example": {
            "batch_total_count": 2,
            "batch_success_count": 0,
            "batch_error_count": 2,
            "errors": [
              {
                "id": "test-1",
                "errors": {
                  "name": [
                    "The property name is required"
                  ]
                }
              },
              {
                "id": "test-2",
                "errors": {
                  "name": [
                    "The property name is required"
                  ]
                }
              }
            ]
          }
        },
        "BatchResponseSuccess": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "batch_total_count": {
              "type": "number"
            },
            "batch_success_count": {
              "type": "number"
            },
            "batch_error_count": {
              "type": "number"
            },
            "errors": {
              "type": "array",
              "items": {
                "type": "object"
              }
            }
          },
          "example": {
            "batch_total_count": 2,
            "batch_success_count": 2,
            "batch_error_count": 0,
            "errors": []
          }
        },
        "404Response": {
          "type": "object",
          "properties": {
            "code": {
              "type": "number"
            },
            "message": {
              "type": "string"
            }
          },
          "example": {
            "code": 404,
            "massage": "Not found"
          }
        },
        "401Response": {
          "type": "object",
          "properties": {
            "code": {
              "type": "number"
            },
            "message": {
              "type": "string"
            }
          },
          "example": {
            "code": 401,
            "massage": "Unauthorized"
          }
        },
        "403Response": {
          "type": "object",
          "properties": {
            "code": {
              "type": "number"
            },
            "data": {
              "type": "array",
              "items": {
                "type": "string"
              }
            }
          },
          "example": {
            "code": 403,
            "massage": "Access denied or quota limit exceeded"
          }
        },
        "blogpostsWithoutInternal": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#\/definitions\/AbstractContentTypeSchemaDefinitionWithoutInternal"
            },
            {
              "type": "object",
              "properties": {
                "title": {
                  "type": "string",
                  "description": ""
                },
                "postContent": {
                  "type": "string",
                  "description": ""
                }
              }
            }
          ],
          "additionalProperties": false,
          "example": {
            "id": "blogposts-1",
            "title": "title",
            "postContent": "postContent"
          }
        },
        "blogposts": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#\/definitions\/AbstractContentTypeSchemaDefinition"
            },
            {
              "type": "object",
              "properties": {
                "title": {
                  "type": "string",
                  "description": ""
                },
                "postContent": {
                  "type": "string",
                  "description": ""
                }
              }
            }
          ],
          "additionalProperties": false,
          "example": {
            "id": "blogposts-1",
            "internal": {
              "contentType": "blogposts",
              "createdAt": "2021-04-20T08:09:02+00:00",
              "updatedAt": "2021-04-20T08:09:02+00:00",
              "deletedAt": ""
            },
            "title": "title",
            "postContent": "postContent"
          }
        },
        "blogpostsList": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#/definitions/SystemListProperties"
            },
            {
              "properties": {
                "data": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/blogposts"
                  }
                }
              }
            }
          ]
        },
        "_mediaWithoutInternal": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#\/definitions\/AbstractContentTypeSchemaDefinitionWithoutInternal"
            },
            {
              "type": "object",
              "properties": {
                "url": {
                  "type": "string",
                  "minLength": 1
                },
                "size": {
                  "type": "number",
                  "minLength": 1
                },
                "type": {
                  "type": "string",
                  "minLength": 1
                },
                "width": {
                  "type": "number"
                },
                "height": {
                  "type": "number"
                },
                "source": {
                  "type": "string",
                  "minLength": 1
                },
                "fileName": {
                  "type": "string",
                  "minLength": 1
                },
                "mimeType": {
                  "type": "string",
                  "minLength": 1
                },
                "extension": {
                  "type": "string",
                  "minLength": 1
                },
                "externalId": {
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
          "additionalProperties": false,
          "example": {
            "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
            "extension": "png",
            "fileName": "example_image.png",
            "mimeType": "image\/png",
            "size": 87258,
            "type": "image",
            "source": "disk",
            "externalId": "",
            "url": "\/image\/0x0\/_media-698d20aa-193a-47b3-be4d-550c1aab47e7.png",
            "height": 517,
            "width": 925
          }
        },
        "_media": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#\/definitions\/AbstractContentTypeSchemaDefinition"
            },
            {
              "type": "object",
              "properties": {
                "url": {
                  "type": "string",
                  "minLength": 1
                },
                "size": {
                  "type": "number",
                  "minLength": 1
                },
                "type": {
                  "type": "string",
                  "minLength": 1
                },
                "width": {
                  "type": "number"
                },
                "height": {
                  "type": "number"
                },
                "source": {
                  "type": "string",
                  "minLength": 1
                },
                "fileName": {
                  "type": "string",
                  "minLength": 1
                },
                "mimeType": {
                  "type": "string",
                  "minLength": 1
                },
                "extension": {
                  "type": "string",
                  "minLength": 1
                },
                "externalId": {
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
          "additionalProperties": false,
          "example": {
            "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
            "extension": "png",
            "fileName": "example_image.png",
            "mimeType": "image\/png",
            "size": 87258,
            "type": "image",
            "source": "disk",
            "externalId": "",
            "url": "\/image\/0x0\/_media-698d20aa-193a-47b3-be4d-550c1aab47e7.png",
            "height": 517,
            "width": 925,
            "internal": {
              "contentType": "_media",
              "createdAt": "2021-04-20T08:09:02+00:00",
              "updatedAt": "2021-04-20T08:09:02+00:00",
              "deletedAt": ""
            }
          }
        },
        "_mediaList": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#/definitions/SystemListProperties"
            },
            {
              "properties": {
                "data": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/_media"
                  }
                }
              }
            }
          ]
        }
      },
      "paths": {
        "/api/v1/content/blogposts": {
          "post": {
            "operationId": "createBlogposts",
            "description": "Allows you to create object of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FcreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "$ref": "#/definitions/blogpostsWithoutInternal"
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/blogposts"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "id": [
                      "This value is already used"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "schema": {
                  "$ref": "#/definitions/403Response"
                }
              }
            }
          },
          "get": {
            "operationId": "listBlogposts",
            "description": "List objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FlistBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "type": "number",
                "default": 1,
                "minimum": 1,
                "x-example": 1
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "type": "number",
                "default": 20,
                "minimum": 1,
                "x-example": 20
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "type": "string",
                "default": "internal.createdAt",
                "x-example": "internal.updatedAt"
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "type": "string",
                "default": "asc",
                "x-example": "asc"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "type": "number",
                "minimum": 0,
                "maximum": 1,
                "default": 0,
                "x-example": 0
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "List filters",
                "type": "string",
                "default": "{}",
                "x-example": "{\"slug\":{\"type\":\"contains\",\"filter\":\"test\"},\"title\":{\"type\":\"contains\",\"filter\":\"test\"}}"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/blogpostsList"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "filters": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "filters": [
                      "Malformed filters json - Syntax error"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/content/blogposts/batch": {
          "post": {
            "operationId": "batchCreateBlogposts",
            "description": "Allows you to create or create and update up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FbatchCreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "updateExisting",
                "required": false,
                "description": "Overwrite existing objects",
                "type": "boolean",
                "default": false
              },
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/blogpostsWithoutInternal"
                  }
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/BatchResponseSuccess"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "$ref": "#/definitions/BatchResponseError"
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/removed": {
          "get": {
            "operationId": "getRemovedBlogposts",
            "description": "Get ids of removed Blog posts objects. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FgetRemovedBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "deletedAfter",
                "required": false,
                "description": "Date from which ids of removed objects should be returned",
                "type": "string",
                "x-example": "2020-01-01 12:00:00"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "example": [
                    "blogposts-1"
                  ]
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "deletedAfter": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "deletedAfter": [
                      "Wrong date format"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/content/blogposts/batch-delete": {
          "post": {
            "operationId": "batchDeleteBlogposts",
            "description": "Allows you to dlete up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FbatchDeleteBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "type": "object",
                  "properties": {
                    "deletedCount": {
                      "type": "number"
                    }
                  },
                  "example": {
                    "deletedCount": 2
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "errors": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "errors": [
                      "Content object: \"blogposts-1\" doesn't exist",
                      "Content object: \"blogposts-2\" is used in another content object."
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/{id}": {
          "get": {
            "operationId": "getBlogposts",
            "description": "Returns all information about Blog posts object. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FgetBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "blogposts-1"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "type": "number",
                "minimum": 0,
                "maximum": 1,
                "default": 0
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/blogposts"
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          },
          "put": {
            "operationId": "updateBlogposts",
            "description": "Allows update of the Blog posts object, it has to have all fields, as this operation overwrites the object. All properties  not included in the payload will be lost. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FupdateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "blogposts-1"
              },
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "$ref": "#/definitions/blogpostsWithoutInternal"
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/blogposts"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "id": [
                      "This value is already used"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "schema": {
                  "$ref": "#/definitions/403Response"
                }
              }
            }
          },
          "delete": {
            "operationId": "deleteBlogposts",
            "description": "Removes Blog posts object.<br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FdeleteBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "blogposts-1"
              }
            ],
            "responses": {
              "204": {
                "description": "OK"
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "errors": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "errors": [
                      "This content object is used in another content object."
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/content/_media": {
          "post": {
            "operationId": "create_media",
            "description": "Allows you to create object of Media type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Fcreate_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "$ref": "#/definitions/_mediaWithoutInternal"
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/_media"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "fileName": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "mimeType": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "size": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "url": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "source": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "extension": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "type": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "id": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "width": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "height": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "id": [
                      "This value is already used"
                    ],
                    "fileName": [
                      "The property fileName is required",
                      "Must be at least 1 characters long"
                    ],
                    "mimeType": [
                      "The property mimeType is required",
                      "Must be at least 1 characters long"
                    ],
                    "size": [
                      "The property size is required",
                      "String value found, but a number is required"
                    ],
                    "url": [
                      "The property url is required",
                      "Must be at least 1 characters long"
                    ],
                    "source": [
                      "The property source is required",
                      "Must be at least 1 characters long",
                      "The value does not match possible options"
                    ],
                    "extension": [
                      "The property extension is required",
                      "Must be at least 1 characters long"
                    ],
                    "type": [
                      "The property type is required",
                      "Must be at least 1 characters long",
                      "The value does not match possible options"
                    ],
                    "width": [
                      "String value found, but a number is required"
                    ],
                    "height": [
                      "String value found, but a number is required"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "schema": {
                  "$ref": "#/definitions/403Response"
                }
              }
            }
          },
          "get": {
            "operationId": "list_media",
            "description": "List objects of Media type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Flist_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "type": "number",
                "default": 1,
                "minimum": 1,
                "x-example": 1
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "type": "number",
                "default": 20,
                "minimum": 1,
                "x-example": 20
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "type": "string",
                "default": "internal.createdAt",
                "x-example": "internal.updatedAt"
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "type": "string",
                "default": "asc",
                "x-example": "asc"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "type": "number",
                "minimum": 0,
                "maximum": 1,
                "default": 0,
                "x-example": 0
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "List filters",
                "type": "string",
                "default": "{}",
                "x-example": "{\"slug\":{\"type\":\"contains\",\"filter\":\"test\"},\"title\":{\"type\":\"contains\",\"filter\":\"test\"}}"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/_mediaList"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "filters": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "filters": [
                      "Malformed filters json - Syntax error"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/content/_media/batch": {
          "post": {
            "operationId": "batchCreate_media",
            "description": "Allows you to create or create and update up to 100 objects of Media type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2FbatchCreate_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "updateExisting",
                "required": false,
                "description": "Overwrite existing objects",
                "type": "boolean",
                "default": false
              },
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/_mediaWithoutInternal"
                  }
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/BatchResponseSuccess"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "$ref": "#/definitions/BatchResponseError"
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/_media/removed": {
          "get": {
            "operationId": "getRemoved_media",
            "description": "Get ids of removed Media objects. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2FgetRemoved_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "deletedAfter",
                "required": false,
                "description": "Date from which ids of removed objects should be returned",
                "type": "string",
                "x-example": "2020-01-01 12:00:00"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "example": [
                    "_media-1"
                  ]
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "deletedAfter": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "deletedAfter": [
                      "Wrong date format"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/content/_media/batch-delete": {
          "post": {
            "operationId": "batchDelete_media",
            "description": "Allows you to dlete up to 100 objects of Media type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2FbatchDelete_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "type": "object",
                  "properties": {
                    "deletedCount": {
                      "type": "number"
                    }
                  },
                  "example": {
                    "deletedCount": 2
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "errors": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "errors": [
                      "Content object: \"_media-1\" doesn't exist",
                      "Content object: \"_media-2\" is used in another content object."
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            }
          }
        },
        "/api/v1/content/_media/{id}": {
          "get": {
            "operationId": "get_media",
            "description": "Returns all information about Media object. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Fget_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "_media-1"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "type": "number",
                "minimum": 0,
                "maximum": 1,
                "default": 0
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/_media"
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          },
          "put": {
            "operationId": "update_media",
            "description": "Allows update of the Media object, it has to have all fields, as this operation overwrites the object. All properties  not included in the payload will be lost. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Fupdate_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "_media-1"
              },
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "$ref": "#/definitions/_mediaWithoutInternal"
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/_media"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "fileName": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "mimeType": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "size": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "url": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "source": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "extension": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "type": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "id": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "width": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "height": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "id": [
                      "This value is already used"
                    ],
                    "fileName": [
                      "The property fileName is required",
                      "Must be at least 1 characters long"
                    ],
                    "mimeType": [
                      "The property mimeType is required",
                      "Must be at least 1 characters long"
                    ],
                    "size": [
                      "The property size is required",
                      "String value found, but a number is required"
                    ],
                    "url": [
                      "The property url is required",
                      "Must be at least 1 characters long"
                    ],
                    "source": [
                      "The property source is required",
                      "Must be at least 1 characters long",
                      "The value does not match possible options"
                    ],
                    "extension": [
                      "The property extension is required",
                      "Must be at least 1 characters long"
                    ],
                    "type": [
                      "The property type is required",
                      "Must be at least 1 characters long",
                      "The value does not match possible options"
                    ],
                    "width": [
                      "String value found, but a number is required"
                    ],
                    "height": [
                      "String value found, but a number is required"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "schema": {
                  "$ref": "#/definitions/403Response"
                }
              }
            }
          },
          "delete": {
            "operationId": "delete_media",
            "description": "Removes Media object.<br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Media%2Fdelete_media'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Media"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "_media-1"
              }
            ],
            "responses": {
              "204": {
                "description": "OK"
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "errors": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "errors": [
                      "This content object is used in another content object."
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/internal/contenttype": {
          "get": {
            "operationId": "getContentDefinitions",
            "description": "Returns an array of user-defined Content Definitions",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "type": "number",
                "default": 1,
                "minimum": 1,
                "x-example": 1
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "type": "number",
                "default": 20,
                "minimum": 1,
                "x-example": 20
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "type": "string",
                "default": "name",
                "x-example": "name"
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "type": "string",
                "default": "asc",
                "x-example": "asc"
              },
              {
                "in": "query",
                "name": "name",
                "required": false,
                "description": "Filters CTDs by name",
                "type": "string",
                "default": "",
                "x-example": "_media"
              },
              {
                "in": "query",
                "name": "label",
                "required": false,
                "description": "Filters CTDs by label",
                "type": "string",
                "default": "",
                "x-example": "Media"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/ContentTypeListResponse"
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          },
          "post": {
            "operationId": "postContentDefinition",
            "description": "Create new ContentTypeDefinition to store new type of ContentObjects",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "$ref": "#/definitions/ContentTypeDefinitionSchema"
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/ContentTypeDefinitionSchema"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "name": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "label": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "schemaDefinition.allOf[1].properties.title.type": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "metaDefinition.propertiesConfig.price.label": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "metaDefinition.propertiesConfig.price.inputType": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
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
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            }
          }
        },
        "/api/v1/internal/contenttype/{id}": {
          "get": {
            "operationId": "getContentDefinition",
            "description": "Returns an user-defined Content Definitions",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "Id of content type definition",
                "type": "string",
                "x-example": "_media"
              },
              {
                "in": "query",
                "name": "resolveRef",
                "required": false,
                "description": "Should the system resolve references done using $ref",
                "type": "boolean",
                "default": false,
                "x-example": false
              },
              {
                "in": "query",
                "name": "strictSchema",
                "required": false,
                "description": "Use 'schema' instead of 'schemaDefinition'",
                "type": "boolean",
                "default": false,
                "x-example": false
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/ContentTypeDefinitionSchema"
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          },
          "put": {
            "operationId": "putContentDefinition",
            "description": "Update ConentTypeDefinition",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "Id of content type definition",
                "type": "string",
                "x-example": "products"
              },
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "$ref": "#/definitions/ContentTypeDefinitionSchema"
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/ContentTypeDefinitionSchema"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "name": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "label": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "schemaDefinition.allOf[1].properties.title.type": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "metaDefinition.propertiesConfig.price.label": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "metaDefinition.propertiesConfig.price.inputType": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
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
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            }
          },
          "delete": {
            "operationId": "deleteContentDefinition",
            "description": "Delete ContentTypeDefinition",
            "tags": [
              "Internal"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "Id of content type definition",
                "type": "string",
                "x-example": "product"
              }
            ],
            "responses": {
              "200": {
                "description": "OK"
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "errors": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  }
                },
                "x-example": {
                  "errors": [
                    "This content type definition is used by Api Key: New key",
                    "Content Type has objects, you can't remove it!"
                  ]
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/search": {
          "get": {
            "operationId": "search",
            "description": "The Flotiq API provides a powerful search engine, which is a wrapper for ElasticSearch queries. We tried to balance between resembling the ES API (for those, who already know it) and keeping it simple and cohesive with Flotiq API. This endpoint provides means for querying content objects that match a set of criteria, with options for:\n\n * limiting search to specific Content Types,\n * limit search to specific fields,\n * weighting fields to modify results scoring,\n * aggregating results by fields.\n\n You can find more information about the Search API in the [Search API docs](https://flotiq.com/docs/API/search/).",
            "tags": [
              "Search API"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "q",
                "required": false,
                "description": "Query",
                "type": "string",
                "default": ""
              },
              {
                "in": "query",
                "name": "fields[]",
                "required": false,
                "description": "Search only in selected fields.",
                "type": "array",
                "items": {
                  "type": "string"
                },
                "collectionFormat": "multi"
              },
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "type": "string",
                "default": "1"
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "type": "string",
                "default": "20"
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "type": "string",
                "default": ""
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "type": "string",
                "default": "asc"
              },
              {
                "in": "query",
                "name": "content_type[]",
                "required": false,
                "description": "Restrict search to content types set",
                "type": "array",
                "items": {
                  "type": "string"
                },
                "collectionFormat": "multi"
              },
              {
                "in": "query",
                "name": "aggregate_by[]",
                "required": false,
                "description": "Field to aggregate results direction (string fields only)",
                "type": "array",
                "items": {
                  "type": "string"
                },
                "collectionFormat": "multi"
              },
              {
                "in": "query",
                "name": "aggregate_by_numeric[]",
                "required": false,
                "description": "Field to aggregate results direction with numeric type",
                "type": "array",
                "items": {
                  "type": "string"
                },
                "collectionFormat": "multi"
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "Filter by object properties. Expected format: filters[property1]=value1&filters[property2]=value2",
                "type": "string",
                "x-example": {
                  "public": true
                }
              },
              {
                "in": "query",
                "name": "post_filters",
                "required": false,
                "description": "Filter by object properties. Use it when you want aggregated counts without filters applied. Expected format: post_filters[property1]=value1&post_filters[property2]=value2",
                "type": "string",
                "x-example": {
                  "public": true
                }
              },
              {
                "in": "query",
                "name": "geo_filters",
                "required": false,
                "description": "Filter by object geolocation properties. Example value: geo_filters[location]=geo_distance,1.50km,40.1,-19.2 (filter name, distance, latitude, longitude). For more information see ElasticSearch docs. Only geo_distance query is supported.",
                "type": "string",
                "x-example": {
                  "location": "geo_distance,1.50km,40.1,-19.2"
                }
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/SearchResponse"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "geo_filters": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "geo_filters": [
                      "Invalid geo filter query provided. Example value is: 'geo_distance,1.50km,40.1,-19.2'. Accepted filter types are: 'geo_distance'."
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/graphql": {
          "post": {
            "operationId": "graphQL",
            "description": "Endpoint for GraphQL Queries for Headless Types",
            "tags": [
              "GraphQL"
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "type": "object",
                  "properties": {
                    "query": {
                      "type": "string",
                      "format": "text",
                      "description": "Graph QL query, for example: query{productsList{id,name}}",
                      "example": "query{_mediaList{id,extension}}"
                    }
                  },
                  "required": [
                    "query"
                  ]
                }
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "type": "object",
                  "example": {
                    "data": {
                      "_mediaList": [
                        {
                          "id": "_media-92328709-64b8-4479-bf00-6e24b7869bb7",
                          "extension": "png"
                        },
                        {
                          "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
                          "extension": "png"
                        },
                        {
                          "id": "_media-21d1beba-48d0-46fa-9bac-55c2afa561a7",
                          "extension": "png"
                        }
                      ]
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            }
          }
        },
        "/api/graphql/schema": {
          "get": {
            "operationId": "graphQLSchema",
            "description": "Get current descripion of GraphQL Schema",
            "tags": [
              "GraphQL"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "x-example": "type Query {\n_media(id: String!): _media\n  _mediaList(page: Int, limit: Int, order_by: String, order_direction: String): [_media]\n}\n\n\"\"\"Auto generated Headless CMS type: _media\"\"\"\ntype _media {\n  id: String\n  url: String\n  size: Float\n  type: String\n  width: Float\n  height: Float\n  source: String\n  fileName: String\n  mimeType: String\n  extension: String\n  externalId: String\n}"
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            },
            "produces": [
              "application/json",
              "text/html"
            ]
          }
        },
        "/api/media": {
          "post": {
            "operationId": "postMedia",
            "description": "Endpoint for media files upload",
            "tags": [
              "Media"
            ],
            "consumes": [
              "multipart/form-data"
            ],
            "produces": [
              "application/json"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "type": "object",
                  "properties": {
                    "file": {
                      "type": "string",
                      "format": "binary",
                      "description": "File to upload"
                    },
                    "type": {
                      "type": "string",
                      "description": "Type of file image|file",
                      "enum": [
                        "image",
                        "file"
                      ],
                      "example": "image"
                    },
                    "save": {
                      "type": "number",
                      "description": "Should file be saved to database on upload: 0|1",
                      "default": 0,
                      "example": 1
                    }
                  },
                  "required": [
                    "file",
                    "type"
                  ]
                }
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/_mediaWithoutInternal"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "file": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "file": [
                      "The mime type of the file is invalid (\"application/gzip\"). Allowed mime types are \"image/gif\", \"image/png\", \"image/jpeg\", \"image/bmp\", \"image/webp\", \"image/svg+xml\", \"image/svg\", \"image/x-icon\", \"image/vnd.microsoft.icon\", \"text/plain\", \"audio/midi\", \"audio/mpeg\", \"audio/webm\", \"audio/ogg\", \"audio/wav\", \"video/webm\", \"video/ogg\", \"video/mp4\", \"application/pdf\", \"application/json\".",
                      "The file is too large (26.17 MB). Allowed maximum size is 10 MB."
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            }
          }
        },
        "/image/{width_height}/{key}": {
          "get": {
            "operationId": "getMedia",
            "description": "Get single media file",
            "tags": [
              "Media"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "width_height",
                "required": true,
                "description": "Expected format: WIDTHxHEIGHT, for example 750x200. Width of the image, or 0 when the file is not an image or it should have original uploaded width, or it should be scaled proportionally with height specified. Height of the image, or 0 when the file is not an image or it should have original uploaded height, or it should be scaled proportionally with width specified",
                "type": "string",
                "default": "0x0"
              },
              {
                "in": "path",
                "name": "key",
                "required": true,
                "description": "Key of the file, it is made from id and extension, e.g. _media-4564.jpg for image with id _media-4564 and jpg extension",
                "type": "string",
                "x-example": "_media-4564.jpg"
              }
            ],
            "produces": [
              "image/jpeg"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "type": "string",
                  "format": "binary"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            }
          }
        }
      }
    }
    ```

??? "Response for user only version 2"

    Example curl request
    ```
    curl -X GET "https://api.flotiq.com/api/v1/open-api-schema.json?version=2&user_only=true" \
         -H 'accept: */*' \
         -H 'X-AUTH-TOKEN: YOUR_API_KEY' \
         -H 'Content-Type: application/json'
    ```

    Response
    ```
    {
      "swagger": "2.0",
      "info": {
        "description": "## Getting started\n\n This is your Flotiq User API that allows you to access your data through the Content API that you defined.\n\n ### Access to data\n\n There are several methods that you can use to access your data:\n * Live API docs - available via <code>Try it out</code> button available next to each endpoint \n * Copying example code on the right side of each endpoint\n * By downloading the SDKs available in mulitple languages.\n * By downloading the Postman collection and importing it into Postman.\n\n\n Each of these methods is described in length in the [user documentation](https://flotiq.com/docs/).\n\n ### Authorization\n\n In order to make use of the provided documentation, example code, SDKs and so on - you will need to pull out your API key. We recommend that you start with the ReadOnly API Key which will allow you to make all the `GET` requests but will error-out when you try to modify content. Please remember to replace the key for `POST`, `PUT` and `DELETE` calls.\n\n It's also possible to use scoped API keys - you can create those in the API keys section of the Flotiq user interface. This will allow you to create a key that only authorizes access to a specific content type (or a set of content types, if you choose so). Read more about how to use and create API keys in the [API keys documentation](https://flotiq.com/docs/API/).\n\n ## Object access\n\n Once you define a Content Type it will become available in your Content API as a set of endpoints that will allow you to work with objects:\n\n * create\n * list\n * update\n * delete\n * batch create\n * retrieve single object.\n\n### Hydration\n\n When you build Content Types that have relation to others your objects will optionally support hydration of related entities. The endpoints that support object retrieval accept a `hydrate` parameter, which can be used to easily fetch hydrated objects. Since this breaks the standard REST concepts - it's not enabled by default, but it's a very handy feature that allows to reduce the amount of HTTP requests sent over the wire and we strongly recommend to use it.",
        "title": "Flotiq User API",
        "version": "2.0.1",
        "contact": {
          "name": "Flotiq Developers",
          "email": "hello@flotiq.com",
          "url": "https://flotiq.com"
        },
        "x-logo": {
          "url": "https://editor.flotiq.com/fonts/fq-logo.svg",
          "altText": "Flotiq User API"
        }
      },
      "x-tagGroups": [
        {
          "name": "User API",
          "tags": [
            "Content: Blog posts"
          ]
        }
      ],
      "host": "localhost:8069",
      "schemes": [
        "http"
      ],
      "basePath": "/",
      "security": [
        {
          "HeaderApiKeyAuth": []
        }
      ],
      "securityDefinitions": {
        "HeaderApiKeyAuth": {
          "description": "Personal Auth token generated for user in Headless CMS application",
          "type": "apiKey",
          "in": "header",
          "name": "X-AUTH-TOKEN"
        }
      },
      "definitions": {
        "AbstractContentTypeSchemaDefinition": {
          "type": "object",
          "properties": {
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
            "id"
          ]
        },
        "AbstractContentTypeSchemaDefinitionWithoutInternal": {
          "type": "object",
          "properties": {
            "id": {
              "type": "string",
              "description": "Unique ID of the object"
            }
          },
          "required": [
            "id"
          ]
        },
        "DataSource": {
          "type": "object",
          "description": "Represents link between data stored internally inside CMS or external",
          "additionalProperties": false,
          "properties": {
            "dataUrl": {
              "type": "string"
            },
            "type": {
              "type": "string",
              "enum": [
                "internal",
                "external"
              ],
              "default": "internal"
            }
          },
          "required": [
            "dataUrl",
            "type"
          ]
        },
        "SystemListProperties": {
          "type": "object",
          "additionalProperties": false,
          "required": [
            "total_count",
            "count",
            "total_pages",
            "current_page"
          ],
          "properties": {
            "total_count": {
              "type": "number",
              "example": 1
            },
            "count": {
              "type": "number",
              "example": 1
            },
            "total_pages": {
              "type": "number",
              "example": 1
            },
            "current_page": {
              "type": "number",
              "example": 1
            }
          }
        },
        "BatchResponseError": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "batch_total_count": {
              "type": "number"
            },
            "batch_success_count": {
              "type": "number"
            },
            "batch_error_count": {
              "type": "number"
            },
            "errors": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "id": {
                    "type": "string"
                  },
                  "errors": {
                    "type": "object",
                    "properties": {
                      "name": {
                        "type": "array",
                        "items": {
                          "type": "string"
                        }
                      }
                    }
                  }
                }
              }
            }
          },
          "example": {
            "batch_total_count": 2,
            "batch_success_count": 0,
            "batch_error_count": 2,
            "errors": [
              {
                "id": "test-1",
                "errors": {
                  "name": [
                    "The property name is required"
                  ]
                }
              },
              {
                "id": "test-2",
                "errors": {
                  "name": [
                    "The property name is required"
                  ]
                }
              }
            ]
          }
        },
        "BatchResponseSuccess": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "batch_total_count": {
              "type": "number"
            },
            "batch_success_count": {
              "type": "number"
            },
            "batch_error_count": {
              "type": "number"
            },
            "errors": {
              "type": "array",
              "items": {
                "type": "object"
              }
            }
          },
          "example": {
            "batch_total_count": 2,
            "batch_success_count": 2,
            "batch_error_count": 0,
            "errors": []
          }
        },
        "404Response": {
          "type": "object",
          "properties": {
            "code": {
              "type": "number"
            },
            "message": {
              "type": "string"
            }
          },
          "example": {
            "code": 404,
            "massage": "Not found"
          }
        },
        "401Response": {
          "type": "object",
          "properties": {
            "code": {
              "type": "number"
            },
            "message": {
              "type": "string"
            }
          },
          "example": {
            "code": 401,
            "massage": "Unauthorized"
          }
        },
        "403Response": {
          "type": "object",
          "properties": {
            "code": {
              "type": "number"
            },
            "data": {
              "type": "array",
              "items": {
                "type": "string"
              }
            }
          },
          "example": {
            "code": 403,
            "massage": "Access denied or quota limit exceeded"
          }
        },
        "blogpostsWithoutInternal": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#\/definitions\/AbstractContentTypeSchemaDefinitionWithoutInternal"
            },
            {
              "type": "object",
              "properties": {
                "title": {
                  "type": "string",
                  "description": ""
                },
                "postContent": {
                  "type": "string",
                  "description": ""
                }
              }
            }
          ],
          "additionalProperties": false,
          "example": {
            "id": "blogposts-1",
            "title": "title",
            "postContent": "postContent"
          }
        },
        "blogposts": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#\/definitions\/AbstractContentTypeSchemaDefinition"
            },
            {
              "type": "object",
              "properties": {
                "title": {
                  "type": "string",
                  "description": ""
                },
                "postContent": {
                  "type": "string",
                  "description": ""
                }
              }
            }
          ],
          "additionalProperties": false,
          "example": {
            "id": "blogposts-1",
            "internal": {
              "contentType": "blogposts",
              "createdAt": "2021-04-20T08:08:13+00:00",
              "updatedAt": "2021-04-20T08:08:13+00:00",
              "deletedAt": ""
            },
            "title": "title",
            "postContent": "postContent"
          }
        },
        "blogpostsList": {
          "type": "object",
          "allOf": [
            {
              "$ref": "#/definitions/SystemListProperties"
            },
            {
              "properties": {
                "data": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/blogposts"
                  }
                }
              }
            }
          ]
        }
      },
      "paths": {
        "/api/v1/content/blogposts": {
          "post": {
            "operationId": "createBlogposts",
            "description": "Allows you to create object of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FcreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "$ref": "#/definitions/blogpostsWithoutInternal"
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/blogposts"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "id": [
                      "This value is already used"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "schema": {
                  "$ref": "#/definitions/403Response"
                }
              }
            }
          },
          "get": {
            "operationId": "listBlogposts",
            "description": "List objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FlistBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "type": "number",
                "default": 1,
                "minimum": 1,
                "x-example": 1
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "type": "number",
                "default": 20,
                "minimum": 1,
                "x-example": 20
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "type": "string",
                "default": "internal.createdAt",
                "x-example": "internal.updatedAt"
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "type": "string",
                "default": "asc",
                "x-example": "asc"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "type": "number",
                "minimum": 0,
                "maximum": 1,
                "default": 0,
                "x-example": 0
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "List filters",
                "type": "string",
                "default": "{}",
                "x-example": "{\"slug\":{\"type\":\"contains\",\"filter\":\"test\"},\"title\":{\"type\":\"contains\",\"filter\":\"test\"}}"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/blogpostsList"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "filters": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "filters": [
                      "Malformed filters json - Syntax error"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/content/blogposts/batch": {
          "post": {
            "operationId": "batchCreateBlogposts",
            "description": "Allows you to create or create and update up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FbatchCreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "updateExisting",
                "required": false,
                "description": "Overwrite existing objects",
                "type": "boolean",
                "default": false
              },
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/blogpostsWithoutInternal"
                  }
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/BatchResponseSuccess"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "$ref": "#/definitions/BatchResponseError"
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/removed": {
          "get": {
            "operationId": "getRemovedBlogposts",
            "description": "Get ids of removed Blog posts objects. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FgetRemovedBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "deletedAfter",
                "required": false,
                "description": "Date from which ids of removed objects should be returned",
                "type": "string",
                "x-example": "2020-01-01 12:00:00"
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  },
                  "example": [
                    "blogposts-1"
                  ]
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "deletedAfter": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "deletedAfter": [
                      "Wrong date format"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        },
        "/api/v1/content/blogposts/batch-delete": {
          "post": {
            "operationId": "batchDeleteBlogposts",
            "description": "Allows you to dlete up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FbatchDeleteBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "type": "object",
                  "properties": {
                    "deletedCount": {
                      "type": "number"
                    }
                  },
                  "example": {
                    "deletedCount": 2
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "errors": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "errors": [
                      "Content object: \"blogposts-1\" doesn't exist",
                      "Content object: \"blogposts-2\" is used in another content object."
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/{id}": {
          "get": {
            "operationId": "getBlogposts",
            "description": "Returns all information about Blog posts object. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FgetBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "blogposts-1"
              },
              {
                "in": "query",
                "name": "hydrate",
                "required": false,
                "description": "Should hydrate relations of object, for now only two levels of hydration are possible",
                "type": "number",
                "minimum": 0,
                "maximum": 1,
                "default": 0
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/blogposts"
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          },
          "put": {
            "operationId": "updateBlogposts",
            "description": "Allows update of the Blog posts object, it has to have all fields, as this operation overwrites the object. All properties  not included in the payload will be lost. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FupdateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "blogposts-1"
              },
              {
                "name": "body",
                "in": "body",
                "schema": {
                  "$ref": "#/definitions/blogpostsWithoutInternal"
                }
              }
            ],
            "consumes": [
              "application/json"
            ],
            "produces": [
              "application/json"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "schema": {
                  "$ref": "#/definitions/blogposts"
                }
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "id": [
                      "This value is already used"
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "schema": {
                  "$ref": "#/definitions/403Response"
                }
              }
            }
          },
          "delete": {
            "operationId": "deleteBlogposts",
            "description": "Removes Blog posts object.<br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3Dc0cfe604b52d4a0fd4a4211d15df76b6#%2FContent: Blog posts%2FdeleteBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "path",
                "name": "id",
                "required": true,
                "description": "ContentObject identifier",
                "type": "string",
                "x-example": "blogposts-1"
              }
            ],
            "responses": {
              "204": {
                "description": "OK"
              },
              "400": {
                "description": "Validation error",
                "schema": {
                  "type": "object",
                  "properties": {
                    "errors": {
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  },
                  "example": {
                    "errors": [
                      "This content object is used in another content object."
                    ]
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "schema": {
                  "$ref": "#/definitions/401Response"
                }
              },
              "404": {
                "description": "Not found",
                "schema": {
                  "$ref": "#/definitions/404Response"
                }
              }
            },
            "produces": [
              "application/json"
            ]
          }
        }
      }
    }
    ```

## Getting your Scoped Open API Schema :fontawesome-solid-triangle-exclamation:{ .pricing-info title="Unavailable in Free subscription plan" }[^1]

If you want to get your Scoped Open API Schema from Flotiq, 
you have to make a call at the following endpoint with the User Defined API key (using a Web browser, Postman or Insomnia):

`
https://api.flotiq.com/api/v1/open-api-schema.json
`

Or run a simple curl request in the terminal:

```
curl -X GET "https://api.flotiq.com/api/v1/open-api-schema.json" \
     -H 'accept: */*' \
     -H 'X-AUTH-TOKEN: YOUR_API_KEY' \
     -H 'Content-Type: application/json'
```

You can use the same request parameters for scoped API schemas as for full API schema.

??? "Response for scoped key, create of blogposts only"

    ```
    {
      "openapi": "3.0.0",
      "info": {
        "description": "## Getting started\n\n This is your Flotiq User API that allows you to access your data through the Content API that you defined.\n\n ### Access to data\n\n There are several methods that you can use to access your data:\n * Live API docs - available via <code>Try it out</code> button available next to each endpoint \n * Copying example code on the right side of each endpoint\n * By downloading the SDKs available in mulitple languages.\n * By downloading the Postman collection and importing it into Postman.\n\n\n Each of these methods is described in length in the [user documentation](https://flotiq.com/docs/).\n\n ### Authorization\n\n In order to make use of the provided documentation, example code, SDKs and so on - you will need to pull out your API key. We recommend that you start with the ReadOnly API Key which will allow you to make all the `GET` requests but will error-out when you try to modify content. Please remember to replace the key for `POST`, `PUT` and `DELETE` calls.\n\n It's also possible to use scoped API keys - you can create those in the API keys section of the Flotiq user interface. This will allow you to create a key that only authorizes access to a specific content type (or a set of content types, if you choose so). Read more about how to use and create API keys in the [API keys documentation](https://flotiq.com/docs/API/).\n\n ## Object access\n\n Once you define a Content Type it will become available in your Content API as a set of endpoints that will allow you to work with objects:\n\n * create\n * list\n * update\n * delete\n * batch create\n * retrieve single object.\n\n### Hydration\n\n When you build Content Types that have relation to others your objects will optionally support hydration of related entities. The endpoints that support object retrieval accept a `hydrate` parameter, which can be used to easily fetch hydrated objects. Since this breaks the standard REST concepts - it's not enabled by default, but it's a very handy feature that allows to reduce the amount of HTTP requests sent over the wire and we strongly recommend to use it.",
        "title": "Flotiq User API",
        "version": "2.0.1",
        "contact": {
          "name": "Flotiq Developers",
          "email": "hello@flotiq.com",
          "url": "https://flotiq.com"
        },
        "x-logo": {
          "url": "https://editor.flotiq.com/fonts/fq-logo.svg",
          "altText": "Flotiq User API"
        }
      },
      "x-tagGroups": [
        {
          "name": "User API",
          "tags": [
            "Content: Blog posts"
          ]
        },
        {
          "name": "Flotiq API",
          "tags": [
            "Search API",
            "Internal",
            "Media",
            "GraphQL"
          ]
        }
      ],
      "servers": [
        {
          "url": "http://localhost:8069",
          "description": "Flotiq Live"
        }
      ],
      "security": [
        {
          "HeaderApiKeyAuth": []
        }
      ],
      "components": {
        "securitySchemes": {
          "HeaderApiKeyAuth": {
            "description": "Personal Auth token generated for user in Headless CMS application",
            "type": "apiKey",
            "in": "header",
            "name": "X-AUTH-TOKEN"
          }
        },
        "schemas": {
          "ContentTypeDefinitionSchema": {
            "type": "object",
            "description": "Representation of content type definition in CMS",
            "properties": {
              "name": {
                "type": "string",
                "minLength": 1
              },
              "label": {
                "type": "string",
                "minLength": 1
              },
              "workflowId": {
                "type": "string"
              },
              "schemaDefinition": {
                "type": "object",
                "description": "JSON Schema object defining structure. Extending AbstractContentTypeSchemaDefinition"
              },
              "metaDefinition": {
                "type": "object",
                "description": "Meta properties for schema definition",
                "$ref": "#/components/schemas/AbstractContentTypeMetaDefinition"
              },
              "internal": {
                "type": "boolean"
              }
            },
            "required": [
              "name",
              "label",
              "schemaDefinition",
              "metaDefinition"
            ],
            "additionalProperties": false,
            "example": {
              "name": "products",
              "label": "Products",
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
                      }
                    }
                  }
                ],
                "required": [
                  "title"
                ]
              },
              "metaDefinition": {
                "propertiesConfig": {
                  "title": {
                    "inputType": "text",
                    "label": "Title",
                    "unique": true
                  }
                },
                "order": [
                  "title"
                ]
              }
            }
          },
          "AbstractContentTypeSchemaDefinition": {
            "type": "object",
            "properties": {
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
              "id"
            ]
          },
          "AbstractContentTypeSchemaDefinitionWithoutInternal": {
            "type": "object",
            "properties": {
              "id": {
                "type": "string",
                "description": "Unique ID of the object"
              }
            },
            "required": [
              "id"
            ]
          },
          "AbstractContentTypeMetaDefinition": {
            "type": "object",
            "description": "Meta definition to describe schema - add unique, fields labels",
            "additionalProperties": false,
            "required": [
              "propertiesConfig",
              "order"
            ],
            "properties": {
              "propertiesConfig": {
                "type": "object",
                "additionalProperties": {
                  "$ref": "#/components/schemas/AbstractPropertiesConfig"
                }
              },
              "order": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "uniqueItems": true
              }
            }
          },
          "DataSource": {
            "type": "object",
            "description": "Represents link between data stored internally inside CMS or external",
            "additionalProperties": false,
            "properties": {
              "dataUrl": {
                "type": "string"
              },
              "type": {
                "type": "string",
                "enum": [
                  "internal",
                  "external"
                ],
                "default": "internal"
              }
            },
            "required": [
              "dataUrl",
              "type"
            ]
          },
          "AbstractPropertiesConfig": {
            "type": "object",
            "additionalProperties": false,
            "required": [
              "label",
              "inputType",
              "unique"
            ],
            "properties": {
              "label": {
                "type": "string"
              },
              "inputType": {
                "type": "string",
                "enum": [
                  "text",
                  "richtext",
                  "textarea",
                  "textMarkdown",
                  "email",
                  "number",
                  "radio",
                  "checkbox",
                  "select",
                  "datasource",
                  "object",
                  "geo"
                ]
              },
              "unique": {
                "type": "boolean"
              },
              "readonly": {
                "type": "boolean"
              },
              "hidden": {
                "type": "boolean"
              },
              "validation": {
                "type": "object",
                "additionalProperties": false,
                "properties": {
                  "relationMultiple": {
                    "type": "boolean"
                  },
                  "relationContenttype": {
                    "type": "string"
                  }
                }
              },
              "options": {
                "type": "array",
                "items": {
                  "type": "string"
                },
                "uniqueItems": true
              },
              "helpText": {
                "type": "string"
              },
              "isTitlePart": {
                "type": "boolean"
              },
              "items": {
                "type": "object",
                "$ref": "#/components/schemas/AbstractContentTypeMetaDefinition"
              }
            }
          },
          "SystemListProperties": {
            "type": "object",
            "additionalProperties": false,
            "required": [
              "total_count",
              "count",
              "total_pages",
              "current_page"
            ],
            "properties": {
              "total_count": {
                "type": "number",
                "example": 1
              },
              "count": {
                "type": "number",
                "example": 1
              },
              "total_pages": {
                "type": "number",
                "example": 1
              },
              "current_page": {
                "type": "number",
                "example": 1
              }
            }
          },
          "SearchResponse": {
            "type": "object",
            "additionalProperties": false,
            "allOf": [
              {
                "$ref": "#/components/schemas/SystemListProperties"
              },
              {
                "properties": {
                  "data": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "properties": {
                        "score": {
                          "type": "number"
                        },
                        "item": {
                          "type": "object",
                          "description": "Source content object stored in Headless CMS"
                        }
                      }
                    }
                  },
                  "summary": {
                    "type": "object",
                    "properties": {
                      "aggregations": {
                        "type": "object"
                      }
                    }
                  }
                },
                "additionalProperties": true
              }
            ]
          },
          "ContentTypeListResponse": {
            "type": "object",
            "additionalProperties": false,
            "allOf": [
              {
                "$ref": "#/components/schemas/SystemListProperties"
              },
              {
                "properties": {
                  "data": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/ContentTypeDefinitionSchema"
                    }
                  }
                }
              }
            ]
          },
          "BatchResponseError": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
              "batch_total_count": {
                "type": "number"
              },
              "batch_success_count": {
                "type": "number"
              },
              "batch_error_count": {
                "type": "number"
              },
              "errors": {
                "type": "array",
                "items": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "string"
                    },
                    "errors": {
                      "type": "object",
                      "properties": {
                        "name": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      }
                    }
                  }
                }
              }
            },
            "example": {
              "batch_total_count": 2,
              "batch_success_count": 0,
              "batch_error_count": 2,
              "errors": [
                {
                  "id": "test-1",
                  "errors": {
                    "name": [
                      "The property name is required"
                    ]
                  }
                },
                {
                  "id": "test-2",
                  "errors": {
                    "name": [
                      "The property name is required"
                    ]
                  }
                }
              ]
            }
          },
          "BatchResponseSuccess": {
            "type": "object",
            "additionalProperties": false,
            "properties": {
              "batch_total_count": {
                "type": "number"
              },
              "batch_success_count": {
                "type": "number"
              },
              "batch_error_count": {
                "type": "number"
              },
              "errors": {
                "type": "array",
                "items": {
                  "type": "object"
                }
              }
            },
            "example": {
              "batch_total_count": 2,
              "batch_success_count": 2,
              "batch_error_count": 0,
              "errors": []
            }
          },
          "404Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "message": {
                "type": "string"
              }
            },
            "example": {
              "code": 404,
              "massage": "Not found"
            }
          },
          "401Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "message": {
                "type": "string"
              }
            },
            "example": {
              "code": 401,
              "massage": "Unauthorized"
            }
          },
          "403Response": {
            "type": "object",
            "properties": {
              "code": {
                "type": "number"
              },
              "data": {
                "type": "array",
                "items": {
                  "type": "string"
                }
              }
            },
            "example": {
              "code": 403,
              "massage": "Access denied or quota limit exceeded"
            }
          },
          "blogpostsWithoutInternal": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#\/components\/schemas\/AbstractContentTypeSchemaDefinitionWithoutInternal"
              },
              {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string",
                    "description": ""
                  },
                  "postContent": {
                    "type": "string",
                    "description": ""
                  }
                }
              }
            ],
            "additionalProperties": false,
            "example": {
              "id": "blogposts-1",
              "title": "title",
              "postContent": "postContent"
            }
          },
          "blogposts": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#\/components\/schemas\/AbstractContentTypeSchemaDefinition"
              },
              {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string",
                    "description": ""
                  },
                  "postContent": {
                    "type": "string",
                    "description": ""
                  }
                }
              }
            ],
            "additionalProperties": false,
            "example": {
              "id": "blogposts-1",
              "internal": {
                "contentType": "blogposts",
                "createdAt": "2021-04-20T08:16:00+00:00",
                "updatedAt": "2021-04-20T08:16:00+00:00",
                "deletedAt": ""
              },
              "title": "title",
              "postContent": "postContent"
            }
          },
          "blogpostsList": {
            "type": "object",
            "allOf": [
              {
                "$ref": "#/components/schemas/SystemListProperties"
              },
              {
                "properties": {
                  "data": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              }
            ]
          }
        }
      },
      "paths": {
        "/api/v1/content/blogposts": {
          "post": {
            "operationId": "createBlogposts",
            "description": "Allows you to create object of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3D1492bd563a117d7f4dda6ad1549d5487#%2FContent: Blog posts%2FcreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/blogpostsWithoutInternal"
                  },
                  "example": {
                    "id": "blogposts-1",
                    "title": "title",
                    "postContent": "postContent"
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/blogposts"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "id": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "id": [
                          "This value is already used"
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "404": {
                "description": "Not found",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/404Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/content/blogposts/batch": {
          "post": {
            "operationId": "batchCreateBlogposts",
            "description": "Allows you to create or create and update up to 100 objects of Blog posts type. <br /><a target='_blank' href='https://apidoc.flotiq.com/?url=http%3A%2F%2Flocalhost%3A8069%2Fapi%2Fv1%2Fopen-api-schema.json%3Fauth_token%3D1492bd563a117d7f4dda6ad1549d5487#%2FContent: Blog posts%2FbatchCreateBlogposts'><button class=\"flotiq-button\">Try it out</button><a>",
            "tags": [
              "Content: Blog posts"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "updateExisting",
                "required": false,
                "description": "Overwrite existing objects",
                "schema": {
                  "type": "boolean",
                  "default": false
                }
              }
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "array",
                    "items": {
                      "$ref": "#/components/schemas/blogpostsWithoutInternal"
                    }
                  },
                  "example": [
                    {
                      "id": "blogposts-1",
                      "title": "title",
                      "postContent": "postContent"
                    },
                    {
                      "id": "blogposts-2",
                      "title": "title",
                      "postContent": "postContent"
                    }
                  ]
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/BatchResponseSuccess"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/BatchResponseError"
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              },
              "403": {
                "description": "Access denied or quota limit exceeded",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/403Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/v1/search": {
          "get": {
            "operationId": "search",
            "description": "The Flotiq API provides a powerful search engine, which is a wrapper for ElasticSearch queries. We tried to balance between resembling the ES API (for those, who already know it) and keeping it simple and cohesive with Flotiq API. This endpoint provides means for querying content objects that match a set of criteria, with options for:\n\n * limiting search to specific Content Types,\n * limit search to specific fields,\n * weighting fields to modify results scoring,\n * aggregating results by fields.\n\n You can find more information about the Search API in the [Search API docs](https://flotiq.com/docs/API/search/).",
            "tags": [
              "Search API"
            ],
            "parameters": [
              {
                "in": "query",
                "name": "q",
                "required": false,
                "description": "Query",
                "schema": {
                  "type": "string",
                  "default": ""
                }
              },
              {
                "in": "query",
                "name": "fields[]",
                "required": false,
                "description": "Search only in selected fields.",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              },
              {
                "in": "query",
                "name": "page",
                "required": false,
                "description": "Listing page number, 1-based",
                "schema": {
                  "type": "string",
                  "default": "1"
                }
              },
              {
                "in": "query",
                "name": "limit",
                "required": false,
                "description": "Page limit",
                "schema": {
                  "type": "string",
                  "default": "20"
                }
              },
              {
                "in": "query",
                "name": "order_by",
                "required": false,
                "description": "Order by field",
                "schema": {
                  "type": "string",
                  "default": ""
                }
              },
              {
                "in": "query",
                "name": "order_direction",
                "required": false,
                "description": "Order direction",
                "schema": {
                  "type": "string",
                  "default": "asc"
                }
              },
              {
                "in": "query",
                "name": "content_type[]",
                "required": false,
                "description": "Restrict search to content types set",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              },
              {
                "in": "query",
                "name": "aggregate_by[]",
                "required": false,
                "description": "Field to aggregate results direction (string fields only)",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              },
              {
                "in": "query",
                "name": "aggregate_by_numeric[]",
                "required": false,
                "description": "Field to aggregate results direction with numeric type",
                "schema": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              },
              {
                "in": "query",
                "name": "filters",
                "required": false,
                "description": "Filter by object properties. Expected format: filters[property1]=value1&filters[property2]=value2",
                "schema": {
                  "type": "object"
                },
                "style": "deepObject",
                "example": {
                  "public": true
                }
              },
              {
                "in": "query",
                "name": "post_filters",
                "required": false,
                "description": "Filter by object properties. Use it when you want aggregated counts without filters applied. Expected format: post_filters[property1]=value1&post_filters[property2]=value2",
                "schema": {
                  "type": "object"
                },
                "style": "deepObject",
                "example": {
                  "public": true
                }
              },
              {
                "in": "query",
                "name": "geo_filters",
                "required": false,
                "description": "Filter by object geolocation properties. Example value: geo_filters[location]=geo_distance,1.50km,40.1,-19.2 (filter name, distance, latitude, longitude). For more information see ElasticSearch docs. Only geo_distance query is supported.",
                "schema": {
                  "type": "object"
                },
                "style": "deepObject",
                "example": {
                  "location": "geo_distance,1.50km,40.1,-19.2"
                }
              }
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/SearchResponse"
                    }
                  }
                }
              },
              "400": {
                "description": "Validation error",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "properties": {
                        "geo_filters": {
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        }
                      },
                      "example": {
                        "geo_filters": [
                          "Invalid geo filter query provided. Example value is: 'geo_distance,1.50km,40.1,-19.2'. Accepted filter types are: 'geo_distance'."
                        ]
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/graphql": {
          "post": {
            "operationId": "graphQL",
            "description": "Endpoint for GraphQL Queries for Headless Types",
            "tags": [
              "GraphQL"
            ],
            "requestBody": {
              "content": {
                "application/json": {
                  "schema": {
                    "type": "object",
                    "properties": {
                      "query": {
                        "type": "string",
                        "format": "text",
                        "description": "Graph QL query, for example: query{productsList{id,name}}",
                        "example": "query{_mediaList{id,extension}}"
                      }
                    },
                    "required": [
                      "query"
                    ]
                  }
                }
              }
            },
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "object",
                      "example": {
                        "data": {
                          "_mediaList": [
                            {
                              "id": "_media-92328709-64b8-4479-bf00-6e24b7869bb7",
                              "extension": "png"
                            },
                            {
                              "id": "_media-698d20aa-193a-47b3-be4d-550c1aab47e7",
                              "extension": "png"
                            },
                            {
                              "id": "_media-21d1beba-48d0-46fa-9bac-55c2afa561a7",
                              "extension": "png"
                            }
                          ]
                        }
                      }
                    }
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        },
        "/api/graphql/schema": {
          "get": {
            "operationId": "graphQLSchema",
            "description": "Get current descripion of GraphQL Schema",
            "tags": [
              "GraphQL"
            ],
            "responses": {
              "200": {
                "description": "OK",
                "content": {
                  "text/html": {
                    "example": "type Query {\n_media(id: String!): _media\n  _mediaList(page: Int, limit: Int, order_by: String, order_direction: String): [_media]\n}\n\n\"\"\"Auto generated Headless CMS type: _media\"\"\"\ntype _media {\n  id: String\n  url: String\n  size: Float\n  type: String\n  width: Float\n  height: Float\n  source: String\n  fileName: String\n  mimeType: String\n  extension: String\n  externalId: String\n}"
                  }
                }
              },
              "401": {
                "description": "Unauthorized",
                "content": {
                  "application/json": {
                    "schema": {
                      "$ref": "#/components/schemas/401Response"
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    ```

!!! note
    Read more about [API keys and scoped API keys](/docs/API/)

[Register to start creating your content objects](https://editor.flotiq.com/register.html){: .flotiq-button}


[^1]: Unavailable in Free subscription plan. Check pricing and limits [here](https://flotiq.com/pricing){:target="_blank"}
