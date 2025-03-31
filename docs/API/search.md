---
tags:
  - Developer
---

title: Flotiq Search API | Flotiq docs
description: Flotiq's search API provides an easy way to query all your content through one endpoint.

# Search API

The Flotiq API provides a powerful search engine, which is a wrapper for ElasticSearch queries. We tried to balance between resembling the ES API (for those, who already know it) and keeping it simple and cohesive with Flotiq API.

You can use the search engine via the `GET /api/v1/search` endpoint to search through all Content Objects.

???+ "Search parameters "
    | Name                   | Type   | Description                                                                                                                                                                                                                                                                                                                                         |
    | ---------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
    | q                      | string | Query (required).                                                                                                                                                                                                                                                                                                                                   |
    | page                   | number | Listing page number                                                                                                                                                                                                                                                                                                                                 |
    | limit                  | number | Results per page, limit 1000                                                                                                                                                                                                                                                                                                                        |
    | content_type[]         | array  | Restrict search to content types set  The expected format: `content_type[]=type1&content_type[]=type2`                                                                                                                                                                                                                                              |
    | aggregate_by[]         | array  | Fields to aggregate results. The expected format: `aggregate_by[]=name&aggregate_by[]=slug`                                                                                                                                                                                                                                                         |
    | aggregate_by_numeric[] | array  | Fields to aggregate results by numeric values. The expected format: `aggregate_by_numeric[]=price&aggregate_by_numeric[]=count`                                                                                                                                                                                                                     |
    | filters[]              | array  | Filter by object properties. The expected format: `filters[propertyName]=value1&filters[propertyName2]=value2`. Follows the rules of the [ElasticSearch Query String Query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-query-string-query.html).                                                                     |
    | geo_filters            | array  | Filter by object geolocation properties. Example value: `geo_distance,1.50km,40.1,-19.2` which means: `filter name`, `distance`, `latitude` and `longitude`. For more information see [ElasticSearch docs](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-geo-distance-query.html). Only the `geo_distance` query is supported.                                                                                               |
    | post_filters           | array  | Filter by object properties. Use it when you want aggregated counts without filters applied. Expected format: `filters[propertyName]=value1&filters[propertyName2]=value2`                                                                                                                                                                          |
    | fields[]               | array  | List of content fields to be searched. The expected format: `fields[]=field1&fields[]=field2`                                                                                                                                                                                                                                                       |
    | order_by               | string | Name of the field to sort results by (they are always primarily sorted by `_score`)                                                                                                                                                                                                                                                                 |
    | order_direction        | string | Direction of sorting (`asc` for ascending or `desc` for descending, default `asc`)                                                                                                                                                                                                                                                                  |
    | random_seed            | number | Seed for random sorting order (overrides `order_by`)                                                                                                                                                                                                                                                                                                |
    | hydrate                | number | Hydrate level for relations to get a schema properly reflecting linked objects                                                                                                                                                                                                                                                                      |

!!! Note
    The Flotiq search endpoint supports querying up to a maximum of 10,000 results.

## Example: Search for "Flotiq" in posts
Request:
```
GET https://api.flotiq.com/api/v1/search?q=Flotiq&content_type[]=post
```
{ data-search-exclude }
    
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
                    "createdAt": "2020-01-22T14:34:36+00:00",
                    "publicVersion": -1,
                    "publishedAt": "",
                    "status": "public"
                }
            },
            "score": 19.395857
        }
    ]
}
```
{ data-search-exclude }

!!! Note
    By default, this endpoint will return only objects with the status `public` [read more](/docs/API/draft-public/draft-public),
    to modify this behavior use [preview mode](/docs/API/draft-public/draft-public/#preview-mode).

## Limit the search to a specific Content Type

You can easily limit the search to a specific Content Type by providing its name in the `content_type[]` argument.

## Order by content field

You can sort the results from the search endpoint by Content Type's field using an "order_by" parameter:

!!! Example
    GET https://api.flotiq.com/api/v1/search?q=Flotiq&content_type[]=post&**order_by=date**

Keep in mind that ordering by a field that is nested in the `object` input type (list) is not possible.

!!! Note
    You may also use the `.keyword` suffix for other data than text fields, for example, if you are using an `id` field that uses a `number` type in Flotiq, you may still want to consider using the `.keyword` suffix when ordering by such field. This will result in slightly faster searching and will sort objects by id alphabetically, not from the highest number to the lowest.

## Limit the search to a specific field

You can restrict queries to a specific field by passing the `fields[]` argument, for example, `fields[]=name` would only search in the `name` field.

## Increase scoring for specific fields

If you'd like to search in several fields but give better score to results that match the query in a specific field - you can use [ElasticSearch's field boosting](https://www.elastic.co/guide/en/elasticsearch/reference/7.6/query-dsl-query-string-query.html#query-string-multi-field) to promote fields. In order to do that - pass the fields and their weights through the `fields[]` argument, for example, `fields[]=title^3&fields[]=content^1` would assign a weight of 3 to the `title` field and a weight of 1 to the `content` field.

## Aggregate results by field

If you'd like to display faceted results of your searches you can use the `aggregate_by[]` param. Add `aggregate_by[]=category` to aggregate by the `category` field. This works best with fields that have discreet values (like status, category, etc), and only works with string fields, if you wish to aggregate with numeric fields, use `aggregate_by_numeric[]` param.

## Get random content objects

You can use the `random_seed` parameter to retrieve random content objects. The `random_seed` parameter accepts a number value for a random number generator. This will sort data in random order, so if you want for example to retrieve two random content objects, you can pass any number to `random_seed` and set the `limit` parameter value to 2.

!!! Note
    Since random_seed is changing the order of retrieved content objects, it will override the value of your `order_by` parameter.

## Increase scoring for specific content types

!!! Note
    Index boosting is available in Custom plan tier.

Index boosting allows you to prioritize results from specific indices when performing searches across multiple content types (CTDs). This feature increases the score of results from certain indices based on user-defined weights, which is useful when some CTDs are more relevant than others.

!!! Example
    Pass the `indices_boost` parameter in your query to boost specific CTDs:

    ```
    /api/v1/search?indices_boost[ctd1Name]=2&indices_boost[ctd2Name]=1.5
    ```
    { data-search-exclude }

    * ctd1Name, ctd2Name – names of the CTDs.
    * 2, 1.5 – boost values (higher means more weight)
