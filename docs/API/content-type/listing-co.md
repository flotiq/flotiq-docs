title: How to list Content Objects | Flotiq docs
description: How to list Content Objects in Flotiq


# Listing content through the API

| Parameter       | Description |
| --------------- | ----------- |
| limit           | Numer of objects on page, default `20` |
| page            | Number of the requested page, 1-based, default `1` |
| order_by        | What field should the list be ordered by, possible values are based on content type schema |
| order_direction | Order direction, possible values: `asc`, `desc`, default `asc` |
| hydrate         | If you want to hydrate datasources in the object, you need to set it to `1`, it will hydrate one level of datasources in objects, you can also use this parameter when requesting single object |
| filters         | Json encoded object containing conditions on which the list of CO should be filtered. The object keys are the name of the parameter (e.g. `title`). The object value is filter object with two keys, `type` describing how the list should be filtered, and `filter` with filter query. Both parameters should be string, you can filter on every subset of object parameters including `internal` parameters (e.g. `internal.created_at`). <br><br>Example filter value: `{"title":{"type":"equals","filter":"Hello world!"}}` |

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
| inRange            | Object parameter must be between `filter` and `filter2`, it is only filter type that has three keys in filter object |

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

**Filtering by relation**, for example, "Show products in category category-1" is possible using [JsonPath](https://github.com/json-path/JsonPath) standard.
You have to care about encoding url params. Dots should also be converted to ASCII codes, for example:

1. Using JsonPath, product category path is `categories[*].dataUrl`
1. Expected value is `/api/v1/content/categories/category-1`
1. Raw query: `GET /api/v1/content/products?categories[*].dataUrl=/api/v1/content/categories/category-1`
1. Encoded query: `GET /api/v1/content/products?categories%255B*%255D%2EdataUrl=%2Fapi%2Fv1%2Fcontent%2Fcategories%2Fcategory-1`
