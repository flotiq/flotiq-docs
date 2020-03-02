# Content Types

## Key concepts

* **Content Repository** - the headless part of the Content Management Platform.
* **Content Type** - a model of data that has been defined inside the Content Repository.
* **Content Type Definition** - a JSON payload that defines the Content Type, it's validation rules, etc.
* **Content Object** - an instance of a Content Type.


The central part of the CMS system is the Content Repository. It enables users to store different kinds of content within the system. The users are allowed to design their content types and define them within the Content Repository using Content Type Definitions (a concept similar to DTDs familiar from XML), described in a [JSON Schema](https://json-schema.org/) format.


Every CTD that is created in the system is validated against the predefined schema of ``ContentTypeDefinitionSchema`` type. A detailed example will be discussed [below](#creating-new-content-types-via-api).

Once created, the Content Type becomes available in the system, and Content Objects of that type can be created, updated, deleted via API calls to their respective endpoints.  

Every Content Object uploaded to the repository requires a Content Type Definition already present in the system. 


Throughout this page, we will follow the example of defining a simple Content Type of a BlogPost. 

Example: 
!!! note "Example: Content Type Definition for BlogPost"
    * Id – string, unique, required 
    * Title – string, required 
    * PostContent – string, required 


## Creating new Content Types 

A new Content Type can be created either by sending a properly formatted POST request to the ``/api/v1/internal/contenttype`` endpoint or through the Content Modeler tool provided with the platform.


### Creating Content Types through the Content modeller

The Content Modeler is a convenient tool for modelling Content Types, which can be accessed through the ``Type definitions`` menu entry.
The Modeler interacts with the ``/api/v1/internal/contenttype`` endpoint on behalf of the user and is seamlessly integrated into the Content Management Platform.

![](images/contentObject4.jpg)

Individual fields can be added using the "Add property" button, which opens the modal window, where the user can define the property name, data type, and it's basic validation:


![](images/contentObject6.jpg)

Editing of the Content Type Definition property is made in the same modal as for adding.

While the Content Type is edited - the current JSON-Schema is always shown in the "JSON SCHEMA PREVIEW" pane:

![](images/contentObject5.jpg)

The ``schemaDefinition`` part of the JSON payload is based on the bare JSON Schema and is fully compatible. 

``` json
"schemaDefinition": {
    "type": "object",
    "allOf": [
        {
            "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition"
        },
        {
            "type": "object",
            "properties": {
                "postContent": {
                    "type": "string"
                }
            }
        }
    ],
    "required": [
        "postContent"
    ],
    "additionalProperties": false
},
```

Any additional properties that may need to be defined to properly display or otherwise handle the fields defined by the user are described in the ``metaDefinition`` section of the payload:

```json
"metaDefinition": {
    "order": [
        "postContent"
    ],
    "propertiesConfig": {
        "postContent": {
            "inputType": "richtext",
            "unique": true
        }
    }
},
```

in this case, the user has specified that the ``Blog Post`` Content Type will have a required field called ``postContent``, which will be rendered as a rich text field and will be unique across all objects of this Content Type.

### Updating Content Types

You can edit the schema of content type using `PUT https://api.flotiq.com/api/v1/internal/contenttype/{id}`, but you should be aware that **previously added objects would not be consistent with the schema**.

## Content Objects

Once a Content Type has been defined in the system - the user can create Content Objects of that Content Type. This is done either directly through the API or via the convenient Content Entry tools provided within the Content Management Platform.

### Authoring content through the Content Entry component

The Content Entry component of the system consists of 2 elements - Content browser and the forms used for editing and authoring content.

To quickly browse and search through large amounts of data, the content browser provides a convenient grid interface that can be customized according to users preferences:

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_7c47fde72a061fafcefc90652080f9f1.png)

From the grid, the users can go to the form that allows them to edit particular Content Object:

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_a33a17f2a8dba98e9108a57f519811fe.png)
