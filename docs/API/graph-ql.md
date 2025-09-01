---
tags:
  - Developer
---

# GraphQL

The Flotiq API supports a GraphQL queries.
It is an alternative way to REST API to get your data. We provide the complete, **always up-to-date** GraphQL description of your data and the endpoint
which understands GraphQL queries for your Content Objects.

## What is a GraphQL?

GraphQL is a query language for APIs.
It is designed to make API more flexible than REST API - it is all about giving clients precisely the data they request.
The developers can pull various data, in the desired shape, with a single API call.

## Graphql in Flotiq

The system supports GraphQL queries for Content Objects.
Endpoints that allow you to interact with the system in a GraphQL way are:

* `GET /api/v2/graphql/schema` - get GraphQL schema,
* `POST /api/v2/graphql` - execute GraphQL query.


### Authentication

To authenticate the GraphQL query, you need to use one of the Application API Keys [available in your
Flotiq Dashboard](/docs/API/).

As in the whole Flotiq API, you can pass your API Key in the following way:

* `X-AUTH-TOKEN` header
* `auth_token` query parameter

!!! Note
    If you need more information on how to get your API Key and how to use it - go to the [API access & scoped keys](/docs/API/) page.

GraphQL API endpoints are unavailable for the User Defined (scoped) API keys.


### Get GraphQL Schema

To get the full GraphQL schema that describes your data you have to call the GET endpoint.
It describes the shape of your current Content Type Definitions, including attribute types,
required fields and relations.

!!! Request
    ```
    curl -X GET 'https://api.flotiq.com/api/v2/graphql/schema' --header 'X-AUTH-TOKEN: YOUR_API_TOKEN'
    ```
    { data-search-exclude }

!!! Response

    === "200 OK"

        Returned when the request was correctly formatted

        ```
        """Filter input for individual field conditions"""
        input FlotiqFieldFilterInput {
            type: String!
            filter: String!
        }

        type Query {
            _media(id: String, field: String, value: String, first: Int, offset: Int, order_by: String, order_direction: String, filter: _mediaFilterInput): _mediaConnection
            _tag(id: String, field: String, value: String, first: Int, offset: Int, order_by: String, order_direction: String, filter: _tagFilterInput): _tagConnection
            category(id: String, field: String, value: String, first: Int, offset: Int, order_by: String, order_direction: String, filter: categoryFilterInput): categoryConnection
            product(id: String, field: String, value: String, first: Int, offset: Int, order_by: String, order_direction: String, filter: productFilterInput): productConnection
        }

        """Auto generated Headless CMS type: _media"""
        type _media {
            internal: flotiq___internal
            id: String!
            alt: String
            url: String!
            size: Float!
            tags: [_tag]
            type: String!
            title: String
            width: Float
            height: Float
            source: String!
            fileName: String
            mimeType: String!
            variants: [_media_variants]
            extension: String!
            externalId: String
        }

        type _mediaConnection {
            edges: [_mediaEdge]
            pageInfo: _mediaPageInfo
            totalCount: Int
        }

        type _mediaEdge {
            node: _media
        }

        """Filter container for fields in _media"""
        input _mediaFilterInput {
            alt: FlotiqFieldFilterInput
            url: FlotiqFieldFilterInput
            size: FlotiqFieldFilterInput
            tags: FlotiqFieldFilterInput
            type: FlotiqFieldFilterInput
            title: FlotiqFieldFilterInput
            width: FlotiqFieldFilterInput
            height: FlotiqFieldFilterInput
            source: FlotiqFieldFilterInput
            fileName: FlotiqFieldFilterInput
            mimeType: FlotiqFieldFilterInput
            variants: FlotiqFieldFilterInput
            extension: FlotiqFieldFilterInput
            externalId: FlotiqFieldFilterInput
        }

        type _mediaPageInfo {
            hasNextPage: Boolean
        }

        type _media_variants {
            name: String
            trim: [_media_variants_trim]
        }

        type _media_variants_trim {
            top: Float
            left: Float!
            right: Float
            width: Float
            bottom: Float
            height: Float
        }

        """Auto generated Headless CMS type: _tag"""
        type _tag {
            internal: flotiq___internal
            id: String!
            name: String
        }

        type _tagConnection {
            edges: [_tagEdge]
            pageInfo: _tagPageInfo
            totalCount: Int
        }

        type _tagEdge {
            node: _tag
        }

        """Filter container for fields in _tag"""
            input _tagFilterInput {
            name: FlotiqFieldFilterInput
        }

        type _tagPageInfo {
            hasNextPage: Boolean
        }

        """Auto generated Headless CMS type: category"""
        type category {
            internal: flotiq___internal
            id: String!
            name: String
            description: String
        }

        type categoryConnection {
            edges: [categoryEdge]
            pageInfo: categoryPageInfo
            totalCount: Int
        }

        type categoryEdge {
            node: category
        }

        """Filter container for fields in category"""
        input categoryFilterInput {
            name: FlotiqFieldFilterInput
            description: FlotiqFieldFilterInput
        }

        type categoryPageInfo {
            hasNextPage: Boolean
        }

        """Default internal type"""
        type flotiq___internal {
            status: String
            createdAt: String
            deletedAt: String
            updatedAt: String
            contentType: String
            objectTitle: String
            latestVersion: Int
        }

        """Auto generated Headless CMS type: product"""
        type product {
            internal: flotiq___internal
            id: String!
            name: String
            slug: String
            price: Float
            categories: [category]
            description: String
            productimage: [_media]
            productgallery: [_media]
        }

        type productConnection {
            edges: [productEdge]
            pageInfo: productPageInfo
            totalCount: Int
        }

        type productEdge {
            node: product
        }

        """Filter container for fields in product"""
            input productFilterInput {
            name: FlotiqFieldFilterInput
            slug: FlotiqFieldFilterInput
            price: FlotiqFieldFilterInput
            categories: FlotiqFieldFilterInput
            description: FlotiqFieldFilterInput
            productimage: FlotiqFieldFilterInput
            productgallery: FlotiqFieldFilterInput
        }

        type productPageInfo {
            hasNextPage: Boolean
        }

        ```
        { data-search-exclude }

    === "401 Unauthorized"

        Returned when API key was missing or incorrect
  
        ```
        {
            "code": 401,
            "massage": "Unauthorized"
        }
        ```
        { data-search-exclude }

### Execute GraphQL Query

To make a query for your objects, you need to call `POST /api/v2/graphql` GraphQL endpoint.
We can specify two types of queries - responsible for retrieving a single object and listing objects.

#### Query single object

To a get single object, you need to pass the object identifier and fields you want to receive in the response.
Example Query in GraphQL language to get `id` and `title` for the product with id `product-1` looks like:

!!! Example

    === "Use id to fetch object"

        The most straight-forward way of querying your Flotiq single object with GraphQL is to use the objects ID:

        !!! GraphQL query

            ```graphql
            {
                product(id: "product-1") {
                    edges {
                        node {
                            id
                            name
                        }
                    }
                }
            }
            ```
            { data-search-exclude }

        To pass this query to the Flotiq, you need to call:

        !!! Request
            ```
            curl -X POST 'https://api.flotiq.com/api/v2/graphql' \
                --header 'X-AUTH-TOKEN: YOUR_API_TOKEN' \
                --header 'Content-Type: application/json' \
                --data-raw '{"query":"{ product(id: \"product-1\") { edges { node { id title }}}}"}'
            ```
            { data-search-exclude }

        !!! Response
            === "200 OK"
                ```json
                {
                    "data": {
                        "product": {
                            "edges": [
                                {
                                    "node": {
                                        "id": "product-1",
                                        "name": "Green Tea"
                                    }
                                }
                            ]
                        }
                    }
                }
                ```
                { data-search-exclude }

    === "Use custom field to fetch object"

        You can use your own field from your content type definition to query Flotiq data with GraphQL.
        To do so, your content type definition has to have a text field with [unique property](../panel/content-types.md?h=unique#property-settings).
        This will allow you to query objects of that type using arguments:

        - field: `<your unique text field name>`,
        - value: `<the value you want to query by>`

        !!! GraphQL query

            ```graphql
            query {
                product(field: "title", value: "Green Tea") {
                    edges {
                        node {
                            id
                            title
                        }
                    }
                }
            }
            ```
            { data-search-exclude }

        To pass this query to the Flotiq, you need to call:

        !!! Request
            ```
            curl -X POST 'https://api.flotiq.com/api/v2/graphql' \
                --header 'X-AUTH-TOKEN: YOUR_API_TOKEN' \
                --header 'Content-Type: application/json' \
                --data-raw '{"query":"{ product(field: \"title\", value: \"Green Tea\") edges{ node{ id title }}}}"}'
            ```
            { data-search-exclude }

        !!! Response
            === "200 OK"
                ```json
                {
                    "data": {
                        "product": {
                            edges: [
                                {
                                    "node": {
                                        "id": "product-1",
                                        "name": "Green Tea"
                                    }
                                }
                            ]
                        }
                    }
                }
                ```
                { data-search-exclude }

!!! Note
    By default, this endpoint will return only objects with the status `public` [read more](/docs/API/draft-public/draft-public),
    to modify this behavior use [preview mode](/docs/API/draft-public/draft-public/#preview-mode).

#### List objects

While listing objects, you can use the optional parameters
`page`, `limit`, `order_by`, `order_direction`, or `filter`.

| Param name     | Param description                                       | Defalut value |
|----------------|---------------------------------------------------------|---------------|
| offset         | Number of records to skip                               | 0             |
| first          | Number of objects on page, default `10`, maximum `1000` | 10            |
| order_by       | What field should list be ordered by                    |               |
| order_direction | Order direction, possible values `asc`, `desc`         | asc           |

The below example shows how to list all products ordered by title, limited to 2 results:

!!! Example

    !!! GraphQL query
        ```graphql
        query {
            product(first: 2, order_by: "name", order_direction: "asc") {
                edges {
                    node {
                        id
                        name
                    }
                }
            }
        }
        ```
        { data-search-exclude }

    To pass this query to the Flotiq, you need to call:

    !!! Request
        ```
        curl -X POST 'https://api.flotiq.com/api/v2/graphql' \
            --header 'X-AUTH-TOKEN: YOUR_API_TOKEN' \
            --header 'Content-Type: application/json' \
            --data-raw '{"query":"query {product(first: 2, order_by: \"name\", order_direction: \"desc\") { edges { node {id, name}}}}"}'
        ```
        { data-search-exclude }

    !!! Response

        === "200 OK"
            ```json
            {
            "data": {
                "product": {
                    "edges": [
                        {
                            "node": {
                                "id": "e883fc8e-31bd-42da-8fab-09d1f8ed767f",
                                "name": "test"
                            }
                        },
                        {
                            "node": {
                                "id": "9c8c7a07-4f71-4167-a38c-c883a92dbbe4",
                                "name": "Green Tea"
                            }
                        }
                    ]
                }
            }
            ```
            { data-search-exclude }

### Relation resolving (hydration)

GraphQLs flexibility also covers object relations (e.g. product has category).
In Flotiq, the related objects are resolved automatically based on the type of `DataSource`.

For example, when we have a product object:
```json
{
   "id":"product-1",
   "categories":[
      {
         "dataUrl":"/api/v1/content/categories/",
         "type":"internal"
      }
   ]
}
```
{ data-search-exclude }

and category:
```json
{
   "id": "category-1",
   "name": "Tea"
}
```
{ data-search-exclude }

The GraphQL query for listing objects including categories will look like:

!!! Example

    !!! GraphQL query
        ```graphql
        query Product {
            product(first: 1) {
                edges {
                    node {
                        id
                        name
                        categories {
                            id
                            name
                        }
                    }
                }
            }
        }
        ```
        { data-search-exclude }

    !!! Request
        ```
        curl --request POST \
            --url 'https://api.flotiq.com/api/v2/graphql?auth_token=__YOUR_AUTH_TOKEN__' \
            --header 'content-type: application/json' \
            --data '{"query":"query{product(first:1)edges{node{{id,name,categories{id,name}}}}}"}'
        ```
        { data-search-exclude }

    !!! Response

        === "200 OK"
            Will return automatically resolved relation:
            ```json
            {
                "data": {
                    "product": {
                        "edges": [
                            {
                                "node": {
                                    "id": "product-1",
                                    "name": "Green Tea",
                                    "categories": [
                                        {
                                            "id": "category-1",
                                            "name": "Tea"
                                        }
                                    ]
                                }
                            }
                        ]
                    }
                }
            }
            ```
            { data-search-exclude }

    As you can see, the related element, `category`, was fetched, including its properties.

### Filtering

GraphQL also allows filtering. The filter object is provided in the variables and follows the same syntax as regular [filtering](/docs/API/content-type/listing-co/?h=listin#filtering-data) in REST API.

!!! Example

    !!! Query
        ```graphql
            query Products($productsFilter: productFilterInput){ 
                product(filter: $productsFilter)
                {
                    edges {
                        node {
                            id
                            name
                            internal {
                                createdAt 
                            }
                        }
                    }
                    totalCount
                    pageInfo {
                        hasNextPage
                    }
                }
            }
        ```
        { data-search-exclude }

    !!! Variables
        ```json
        {
            "productsFilter": {
                "name": {
                    "type": "contains",
                    "filter": "Rooibos"
                }
            }
        }
        ```
        { data-search-exclude }
    !!! Request
        ```
        curl --request POST \
            --url 'https://api.flotiq.com/api/v2/graphql?auth_token=__YOUR_AUTH_TOKEN__' \
            --header 'content-type: application/json' \
            --data '{
                "query": "query Products($productsFilter: productFilterInput) { product(filter: $productsFilter) { edges { node { id name internal { createdAt } } } totalCount pageInfo { hasNextPage } } }",
                "variables": {
                    "productsFilter": {
                        "name": {
                            "type": "contains",
                            "filter": "Rooibos"
                        }
                    }
                }
            }'
        ```
        { data-search-exclude }

    !!! Response

        === "200 OK"
            Will return filtered data:
            ```json
            {
                "data": {
                    "product": {
                    "edges": [
                        {
                            "node": {
                                "id": "e883fc8e-31bd-42da-8fab-09d1f8ed767f",
                                "name": "Rooibos",
                                "internal": {
                                    "createdAt": "2025-08-25T10:31:54+00:00"
                                }
                            }
                        }
                    ],
                    "totalCount": 1,
                    "pageInfo": {
                        "hasNextPage": false
                    }
                }
            }
            ```
            { data-search-exclude }
