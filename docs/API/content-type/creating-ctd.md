title: How to add Content Type Definitions | Flotiq docs
description: How to add Content Type Definitions in Flotiq

# Creating new Content Types 

A new <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> can be created either by sending a properly formatted POST request to the ``/api/v1/internal/contenttype`` endpoint or through the Content Modeler tool provided with the platform.


## Creating new Content Types via API

The API endpoint ``/api/v1/internal/contenttype`` can be used to interact with <abbr title="Content Type Definition - a JSON payload that defines the Content Type, it's validation rules, etc.">Content Type Definitions</abbr> inside the Content Repository. The endpoint documentation is provided in the API docs and describes the following actions:

Creating a new <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> is simply a ``POST`` call with a payload similar to:

??? "Content Type POST payload"
    ```json
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

`name` is the name of the <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> and name of the endpoints that will be generated to handle requests with <abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr>  of that type.

`label` is only for displaying the name correctly on the CMS panel.

The `schemaDefinition` part of the JSON payload is based on the bare JSON Schema and is fully compatible. It holds information about properties of the <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">CT</abbr> (in the `properties` key), its types and which properties are required (`required` key). It always should have `"type": "object"`, as it is an object, and `"additionalProperties": false` to ensure that API users will not post garbage to the objects of this CTD. To ensure that all objects have id property <abbr title="Content Type Definition - a JSON payload that defines the Content Type, it's validation rules, etc.">CTD</abbr> also should have information about the connection with `AbstractContentTypeSchemaDefinition` using:
```
"allOf": [
    {
        "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
    }
],
```

In the case of this example, it will add two properties, `title` and `postContent` which are both strings and required.

`metaDefinition` is used to tell CMS panel how to render a form for the Content Object, it holds information about the order of the properties (`order` key, which should contain all properties of the object), and about type and validation of the field. It also includes information on relations of the object with other Content Types. 

In this case, Blog Post will have `title` property which will be unique and will render as text input in CMS panel and `postContent` which can be duplicated and will be presented as CKEditor input in CMS panel. First input in the form in CMS panel will be `title` input, and second will be `postContent`.

Full curl request:
```
curl -X POST "https://api.flotiq.com/api/v1/internal/contenttype" -H 'accept: */*' -H 'X-AUTH-TOKEN: YOUR_API_KEY' -H 'Content-Type: application/json' --data-binary '{"name":"blogposts","label":"Blog Posts","schemaDefinition":{"type":"object","allOf":[{"$ref":"#/components/schemas/AbstractContentTypeSchemaDefinition"},{"type":"object","properties":{"title":{"type":"string"},"postContent":{"type":"string"}}}],"required":["title","postContent"],"additionalProperties":false},"metaDefinition":{"propertiesConfig":{"title":{"label":"Title",inputType":"text","unique":true},"postContent":{"label":"Post content","inputType":"richtext","unique":false}},"order":["title","postContent"]}}'
```

After such call is made and <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> is created - the User API is immediately extended to support interaction with this new Content Type:

![](../images/endpoints.png){: .center .width75 .border}

All Content Types have automatically added properties from `AbstractContentTypeSchemaDefinition`; they are:

* id - string identifier of Content Object, required in all requests, unique within the Content Type,
* internal - object necessary to proper work of CMS backend (information about dates of creation and update, the whole object is described in JSON below). 

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
                        }
                    }
                }
            },
            "required": [
                "id"
            ]
        },
    ```

### Property types

Property types (as of `schemaDefinition` properties), recognized by CMS panel:

??? "Property types"
    | type    | Description                                                                                                                                  | Additional keys in property | Description                                                                                                                                    |
    | ------- | -------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
    | string  | Any string data that includes date and files                                                                                                 | none allowed                |
    | number  | Any number, integer, float and double                                                                                                        | none allowed                |
    | boolean | Represents two values `true` and `false`. Note that truthy and falsy values such as "true", "", 0 or null are not considered boolean values. | none allowed                |
    | array   | Used for lists or relations.                                                                                                                 | items                       | For relations: it has to be an object containing `{"$ref": "#/components/schemas/DataSource"}`, as the items of the array are objects described in DataSource schema.<br>For list items: it should be a valid json schema following the same restrictions as wrapping schema |
    |         |                                                                                                                                              | minItems                    | `0` for a not required property, and `1` for required property                                                                                 |
    | object  | Used for geo point type                                                                                                                      | properties                  | must be `{"lat": {"type": "number"},"lon": {"type": "number"}}`
    |         |                                                                                                                                              | additionalProperties        | must be `false`
    |         |                                                                                                                                              | type                        | must be `object`
    |         |                                                                                                                                              | required                    | if the field is required it must be `["lat","lon"]`

### Meta definition properties types

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
    | object     | array                    | Renders one or multiple forms for nested `meta definition` element                                                 | items                       | `Meta definition` for single list item                | same as in wrapping meta definition (`order` and `propertiesConfig`) |
    | datasource | array                    | Renders picker for choosing the objects of specified or any other Content Type, depending on `validation` property | unique                      | *                                                     | none allowed        |
    |            |                          |                                                                                                                    | validation                  | Object contains restrictions for datasource           | relationContenttype | Name of the Content Type to which relation should be restricted |
    |            |                          |                                                                                                                    |                             |                                                       | relationMultiple    | Boolean value informing if the array should have only one ora can have more elements |
    | geo        | object                   | Renders two fields, one for the latitude, second for the longitude, saves it as an object                          | unique                      | *                                                     | none allowed        | 
    
    *Information if the value of the property should be unique in all object of the specified type. 

## Creating Content Types through the Content modeller

It is described in the public part of the documentation.
