---
tags:
  - Developer
---

title: Draft & Public
description: Draft & Public Mode is a feature that allows teams to manage different content variants in the CTD system

# Draft & Public

The Draft & Public mode is designed to manage the visibility of content objects in the system and facilitate the publishing process. 
When enabled, users can utilize statuses such as `draft`, `public`, `modified`, and `archived` to better organize content and control its state.

This feature is disabled by default, and all saved content objects will have their status set to `public`.

!!! Note
    By default, all listing endpoints (like [listing content objects](/docs/API/content-type/listing-co/)) will return only
    objects with the status `public`, to modify this behavior use header [X-MODE](/docs/API/draft-public/draft-public/#preview-mode).

## Enabling Draft & Public feature on Content definition

To enable `Draft & Public` feature, pass into request payload  `draftPublic: true` while creating `Content Type Definition`.

!!! Example
    ```bash
        curl -X POST "https://api.flotiq.com/api/v1/internal/contenttype" \
        --header "Content-Type: application/json" \
        --header "X-AUTH-TOKEN: your_token" \
        --data-raw '{
          "name": "post",
          "label": "Post",
          "draftPublic": true,
          "featuredImage": [],
          "schemaDefinition": {...},
          "metaDefinition": {...}
        }'
    ```
    { data-search-exclude }

!!! Note
    Content object will be created with `Draft & Public` feature **enabled**. 
    From now all newly created content objects will be saved with a status `draft`


## Usage

### Available content statuses
Draft & Public provides sets of content statuses to help teams manage and organize their content,
the list of each status with a brief explanation has been written below:

- **Draft** default status for all newly created content objects.
- **Public** is a status for your production ready content. 
- **Modified** When object in the status `public`, is edited then a new version with a `public` status will be created
- **Archived** Status for content withdrawn from `public` state

!!! Note
    **Only content in status `public` will be visible via listing API**, by default, to access content in different statuses,
    use header [X-MODE](#preview-mode).

### Draft & Public endpoints
Flotiq API provides a set of endpoints to manage the status of your content.

- [`/api/v1/content/:content-type-definition-name/:content-type-object-id/publish`](#publishing-content)
- [`/api/v1/content/:content-type-definition-name/batch-publish`](#batch-publish-content)
- [`/api/v1/content/:content-type-definition-name/:content-type-object-id/unpublish`](#unpublish-content)
- [`/api/v1/content/:content-type-definition-name/batch-unpublish`](#batch-unpublish-content)
- [`/api/v1/content/:content-type-definition-name/:content-type-object-id/archive`](#content-archiving)
- [`/api/v1/content/:content-type-definition-name/batch-archive`](#batch-archive-content)

### Publishing content
To make object that satisfies all requirements, available for all users, we have to make it public,
to do so we need to call the endpoint: `/api/v1/content/:content-type-definition-name/:content-type-object-id/publish` 
with `:content-type-definition-name` and `:content-type-object-id` parameters matching your content.
!!! Request
    ```
    curl -X GET 'https://api.flotiq.com/api/v1/posts/post-1/publish' --header 'X-AUTH-TOKEN: YOUR_API_TOKEN'
    ```
    { data-search-exclude }

!!! Note
    Now object with the id post-1, **will have the status Public and will be visible, by default in the listing API**

#### Batch publish content
There is a way to publish up to 100[^1] Content Objects at once. 
It is possible by using the `/api/v1/content/:content-type-definition-name/batch-publish` 
endpoint with a body consisting of an array containing object IDs as strings.

!!! Example
    ```sh
    curl -X POST "https://api.flotiq.com/api/v1/content/blogposts/batch-publish" \
        --header "Authorization: Bearer YOUR_API_KEY" \
        --header "Content-Type: application/json" \
        --data-raw '["post-1", "post-2", "post-3"]'
    ```
    { data-search-exclude }

### Unpublish content
If you wish to revert the public version to the draft, to make content some adjustments you can use:

`/api/v1/content/:content-type-definition-name/:content-type-object-id/unpublish` 

endpoint with `:content-type-definition-name` and `:content-type-object-id` parameters matching your content.

!!! Request
    ```
    curl -X GET 'https://api.flotiq.com/api/v1/posts/post-1/unpublish' --header 'X-AUTH-TOKEN: YOUR_API_TOKEN'
    ```
    { data-search-exclude }

!!! Note
    Now object with the id post-1, **will have the status `draft` and will not be visible, by default in the listing API**

#### Batch unpublish content
There is a way to unpublish up to 100[^1] Content Objects at once. 
It is possible by using the `/api/v1/content/:content-type-definition-name/batch-unpublish` 
endpoint with a body consisting of an array containing object IDs as strings.

!!! Example
    ```sh
    curl -X POST "https://api.flotiq.com/api/v1/content/blogposts/batch-unpublish" \
        --header "Authorization: Bearer YOUR_API_KEY" \
        --header "Content-Type: application/json" \
        --data-raw '["post-1", "post-2", "post-3"]'
    ```
    { data-search-exclude }

### Content archiving
If you wish to archive the public version, to make content withdrawn from the Public state and mark it as `archived` you can use:

`/api/v1/content/:content-type-definition-name/:content-type-object-id/archive`

endpoint with `:content-type-definition-name` and `:content-type-object-id` parameters matching your content.

!!! Request
    ```
    curl -X GET 'https://api.flotiq.com/api/v1/posts/post-1/archive' --header 'X-AUTH-TOKEN: YOUR_API_TOKEN'
    ```
    { data-search-exclude }

!!! Note
    Now object with the id post-1, **will have the status `archived` and will not be visible, by default in the listing API**

#### Batch archive content
There is a way to archive up to 100[^1] Content Objects at once. 
It is possible by using the `/api/v1/content/:content-type-definition-name/batch-archive` 
endpoint with a body consisting of an array containing object IDs as strings.

!!! Example
    ```sh
    curl -X POST "https://api.flotiq.com/api/v1/content/blogposts/batch-archive" \
        --header "Authorization: Bearer YOUR_API_KEY" \
        --header "Content-Type: application/json" \
        --data-raw '["post-1", "post-2", "post-3"]'
    ```
    { data-search-exclude }

### Draft & Public cascade actions
Endpoints for publishing, unpublishing and archiving content with draft&public workflow enabled can be used with cascade options, so the system will automatically publish, unpublish or archive all related objects. This allows complex content structures with references to be handled consistently and ensures that dependent content remains in sync with the parent object's state.

In order to use cascade action use `?hydrate=<value>` query parameter, exactly how it's done with [hydration for listing content objects](/docs/API/content-type/listing-co#hydrating-objects).

!!! Request
    ```sh
    curl -X GET 'https://api.flotiq.com/api/v1/posts/post-1/publish?hydrate=1'
        --header 'X-AUTH-TOKEN: YOUR_API_TOKEN'
    ```
    { data-search-exclude }

The max depth of the relation-chain that the system will scan for Draft&Public objects with relation to the object in request is defined by the value for `hydrate` query parameter, for example `hydrate=1` will make Flotiq use the draft&public action on the target objects and it's related objects, but not further nested relations.

!!! Note
    `hydrate=1` is currently the highest level of hydration available for cascade actions.

## Preview mode
Listing content endpoints (listed below) will return, by default only content in status `Public`,
this behavior will affect only content definitions with `Draft & Public` feature **enabled**

- [Listing content](/docs/API/content-type/listing-co/)
- [Getting single content object](/docs/API/content-type/getting-co/)
- [GraphQL API](/docs/API/graph-ql/)
- [Search API](/docs/API/search/)

### X-MODE header
If you wish to modify this behavior, Flotiq API provides `X-MODE` HTTP header which **can enable returning** 
content objects with status different from `public` 

Let's go through a specific case. Suppose we have several objects of type `post` with enabled `Draft & Public` listed in the table below.
Let's see how the API response will look depending on the provided headers.

| Object-id | Status     |
|-----------|------------|
| post-1    | `public`   |
| post-2    | `public`   |
| post-3    | `draft`    |
| post-4    | `archived` |


!!! Example
    === "X-MODE header not included"
        !!! Note
            Take note that **we are not including** the X-MODE header.
    
        !!! Request
            ```bash
                curl -X GET 'https://api.flotiq.com/api/v1/post' --header 'X-AUTH-TOKEN: YOUR_API_TOKEN'
            ```
            { data-search-exclude }
        
        !!! Response
            Notice that the response includes only objects with the `public` status.

            ```json
                [
                    {
                        "id": "post-1",
                        // ...
                        "internal":{
                            // ...
                            "publicVersion": 23123123123,
                            "publishedAt": "2020-01-09T12:30:38+00:00",
                            "status": "public"
                        }
                    },
                    {
                        "id": "post-2",
                        // ...
                        "internal":{
                            // ...
                            "publicVersion": 23123123172,
                            "publishedAt": "2025-01-09T13:30:38+00:00",
                            "status": "public"
                        }
                    },
                ]
            ```
            { data-search-exclude }
    
    === "X-MODE header included"

        !!! Note
            Take note that **we are including** the X-MODE header.
        
        !!! Request
            ```bash
                curl -X GET 'https://api.flotiq.com/api/v1/post' \
                --header 'X-AUTH-TOKEN: YOUR_API_TOKEN' \
                --header 'X-MODE: preview'
            ```
            { data-search-exclude }
                
        !!! Response
            In the response, all objects are present regardless of their status.
            ```json
                [
                    {
                        "id": "post-1",
                        // ...
                        "internal":{
                            // ...
                            "publicVersion": 23123123123,
                            "publishedAt": "2020-01-09T12:30:38+00:00",
                            "status": "public"
                        }
                    },
                    {
                        "id": "post-2",
                        // ...
                        "internal":{
                            // ...
                            "publicVersion": 23123123172,
                            "publishedAt": "2025-01-09T13:30:38+00:00",
                            "status": "public"
                        }
                    },
                    {
                        "id": "post-3",
                        // ...
                        "internal":{
                            // ...
                            "publicVersion": 23123123123,
                            "publishedAt": "2020-01-09T12:30:38+00:00",
                            "status": "draft"
                        }
                    },
                    {
                        "id": "post-4",
                        // ...
                        "internal":{
                            // ...
                            "publicVersion": 23123123172,
                            "publishedAt": "2025-01-09T13:30:38+00:00",
                            "status": "archived"
                        }
                    },
                ]
            ```
            { data-search-exclude }

[^1]: Limit can be changed in the [<< plan_names.paid_3 >> plan](https://flotiq.com/pricing){:target="_blank"}
