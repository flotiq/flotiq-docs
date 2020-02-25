title: Flotiq Search API | Flotiq docs
description: Flotiq's search API provides an easy way to query all your content through one endpoint.

#Search API

The Flotiq API contains search engine implementation. 
You can use the `GET ​/api​/v1​/search` endpoint to search through all Content Objects.

??? "Search parameters "
    | Name            | Type   | Description                                                                                   |
    |-----------------| -------| ----------------------------------------------------------------------------------------------|
    | q               | string | Query (required)                                                                              |
    | page            | number | Listing page number                                                                           |
    | limit           | number | Results per page                                                                              |
    | order_by        | string | Order by field                                                                                |
    | order_direction | string | Order direction                                                                               |
    | content_type    | array  | Restrict search to content types set                                                          |
    | aggregate_by    | array  | Fields to aggregate results direction                                                         |
    | filters         | object | Filter by object properties. Expected format: `{propertyName: value1, propertyName2: value2} `|
    | post_filters    | object | Filter by object properties. Use it when you want aggregated counts without filters applied. Expected format: `{property1: value1, property2: value2}` |                                                                                              |
    | fields          | array  | List of content fields to be searched                                                         |
    | order_by        | string | Name of the field to sort results by (they are always primarily sorted by `_score`)            |
    | order_direction | string | Direction of sorting (`asc` for ascending or `desc` for descending, default `asc`)           |

## Example: Search for "Flotiq" in posts

Request: 
```
GET https://api.flotiq.com/api/v1/search?q=Flotiq&content_type[]=post
```

    
Response:
```json
{
    "total_count": 1,
    "count": 1,
    "total_pages": 1,
    "current_page": 1,
    "summary": {
        "aggregations": []
    },
    "data": [
        {
            "item": {
                "lead": "You model, author and consume your content, your way. Flotiq is an API-first CMS that takes care of hosting, securing and scaling to guarantee your content is always on.",
                "object_data": "{\"id\": \"post-900923\", \"lead\": \"You model, author and consume your content, your way. Flotiq is an API-first CMS that takes care of hosting, securing and scaling to guarantee your content is always on.\", \"slug\": \"your-content-your-way\", \"title\": \"Your content, your way!\", \"public\": true, \"content\": \"Flotiq provides an easy way to describe your content, populate your system with large amounts of data and consume it.\", \"internal\": {\"createdAt\": \"2020-01-22T14:34:36+00:00\", \"deletedAt\": \"\", \"updatedAt\": \"2020-01-22T14:34:36+00:00\", \"contentType\": \"post\"}}",
                "organization_id": "ea283dbe-3205-11ea-aed7-0242ac130003",
                "deleted_at": null,
                "content": "Flotiq provides an easy way to describe your content, populate your system with large amounts of data and consume it.",
                "id": "post-900923",
                "slug": "your-content-your-way",
                "updated_at": null,
                "content_type_definition_id": "6c8f42d8-3208-11ea-aed7-0242ac130003",
                "created_at": "2020-01-22T14:34:36.000Z",
                "@timestamp": "2020-01-22T14:34:40.119Z",
                "title": "Your content, your way!",
                "public": true,
                "internal": {
                    "deletedAt": "",
                    "updatedAt": "2020-01-22T14:34:36+00:00",
                    "contentType": "post",
                    "createdAt": "2020-01-22T14:34:36+00:00"
                }
            },
            "score": 19.395857
        }
    ]
}
```

