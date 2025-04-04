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
        -H "Content-Type: application/json" \
        -H "X-AUTH-TOKEN: your_token" \
        -d '{
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
- [`/api/v1/content/:content-type-definition-name/:content-type-object-id/unpublish`](#unpublish-content)
- [`/api/v1/content/:content-type-definition-name/:content-type-object-id/archive`](#Content archiving)

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
