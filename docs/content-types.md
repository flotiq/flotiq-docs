# Content Types


## Taxonomy 

The central part of the CMS system is the Content Repository. It enables users to store different kinds of content within the system. The users are allowed to design their own content types and define them within the Content Repository by means of Content Type Definitions (concept similar to DTDs familiar from XML), described in a JSON Schema format. The CTDs are uploaded to the Content Repository via an API call to the /**** endpoint. Every CTD has to follow a defined schema, compatible with the following JSON Schema: 

 

 

Every Content Object uploaded to the repository requires a Content Type Definition already present in the system. 

 

Once created the Content Type becomes available in the system and Content Objects of that type can be created, updated, deleted via API calls to their respective endpoints.  

 

Example: 
!!! note "Example: Content Type Definition for Product"
    * Id – string, unique, required 
    * Name – string, required 
    * Description – string, required 
    * Price – number, required 
    * PromoMessage – string 

Would be defined in the Content Repository via a POST with a payload similar to: 

```
{ 
    "name": "product", 
    "label": "Product", 
    "schemaDefinition": { 
        "type": "object", 
        "allOf": [ 
            { 
                "$ref": "#/components/schemas/AbstractContentTypeSchemaDefinition" 
            } 
        ], 

        "properties": { 
            "id": { 
                "type": "number" 
            }, 
            "name": { 
                "type": "string" 
            }, 
            "description": { 
                "type": "string" 
            }, 
            "price": { 
                "type": "number" 
            }, 
            "promoMessage": { 
                "type": "string" 
            } 
        }, 
        "required": [ 
            "id", 
            "name", 
            "description", 
            "price" 
        ], 
        "additionalProperties": false 
    }, 

    "metaDefinition": { 
        "propertiesConfig": { 
            "id": { 
                "inputType": "number", 
                "unique": true 
            }, 
            "name": { 
                "inputType": "text", 
                "unique": false 
            }, 
            "description": { 
                "inputType": "textarea", 
                "unique": false 
            }, 
            "price": { 
                "inputType": "number", 
                "unique": false 
            }, 
            "promoMessage": { 
                "inputType": "text", 
                "unique": false 
            } 
        }, 
        "order": [ 
            "id", 
            "name", 
            "description", 
            "price", 
            "promoMessage" 
        ] 
    } 
} 
```

