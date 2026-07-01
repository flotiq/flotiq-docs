---
tags:
  - Developer
---

title: Flotiq workflows - content publishing | Flotiq documentation
description: Flotiq support for custom workflows helps teams collaborate and produce quality content.

# Flotiq workflows

!!! note
    Flotiq workflows can be customized only in the << plan_names.paid_3 >> plan.
    Reach out to us to discuss possible implementation.

## Overview

Workflows are a powerful feature that helps teams collaborate and produce quality content. Flotiq implements workflows for all content types defined in the system. The default workflow supports only a single state - `saved`. Every content object in the system carries a `workflowState` field under the `internal` section. Custom workflows allow you to define additional states and transitions that match your editorial process.

## Workflows vs Draft & Public

Flotiq offers two distinct systems for managing content state. Choose the one that fits your workflow:

| Aspect                 | Workflows                                                                        | Draft & Public                                                                                                                                       |
|------------------------|----------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| **States**             | Custom - examples: draft, review, public, archive                                | Fixed: draft, public, modified, archived                                                                                                             |
| **State field**        | `workflowState` under `internal`                                                 | `status` under `internal`                                                                                                                            |
| **Enable**             | Custom workflows (paid plan)                                                     | `draftPublic: true` on Content Type Definition                                                                                                       |
| **API endpoints**      | `/api/v1/workflow/:type/:id` for state transitions                               | `/api/v1/content/:type/:id/publish`, `/unpublish`, `/archive`                                                                                        |
| **Use case**           | Complex multi-step approval processes (e.g., draft → review → approval → public) | Simple two-state publishing (draft vs public)                                                                                                        |
| **Visibility control** | Public state requires using `x-visibility: public` header                        | Listing endpoints, single-object reads, GraphQL, and search respect Draft & Public states by default; use `X-MODE: preview` header to include drafts |

**Key difference**: Workflows are for **defining custom editorial processes** with flexible states and transitions. Draft & Public is a **pre-built publishing system** optimized for separating published content from unpublished changes.

You cannot use both systems simultaneously on a single Content Type Definition. Choose one based on your requirements.

```json
{
    "id": "snipcart-584874",
    "name": "Gunpowder Temple Of Heaven",
    "image": [
        {
            "type": "internal",
            "dataUrl": "/api/v1/content/_media/_media-5e17192889e87"
        }
    ],
    "price": 22,
    "internal": {
        "createdAt": "2020-01-08T13:29:28+00:00",
        "deletedAt": "",
        "updatedAt": "2020-01-09T12:30:38+00:00",
        "contentType": "snipcart",
        "workflowState": "saved"
    }
}
```
{ data-search-exclude }

!!! note "Default workflow"
    The default workflow has only one state: `saved`. See the comparison table above to learn when to use Workflows versus Draft & Public.

## Custom workflows

Custom workflows can be defined in Flotiq, for example a simple editorial workflow that introduces the following states:

- draft
- review
- public
- archive

with the following possible transitions

![](./images/publishing-workflow.svg){: .center}

can be used to help teams curate content, manage publication and archiving of content.

!!! hint
    Transitions are named using the following rule: `_fromState_toState`


### Changing the workflow of a Content Type Definition

Workflows are defined at the Content Type Definition level, in order to change the workflow of a Content Type Definition from the default one - execute a `PUT` update on the `/api/v1/internal/contenttype/:label` endpoint and provide the additional attribute pointing to the workflow identifier:

```json
{
    "id": "d954df66-3623-11a4-ba9a-ca80993425cb",
    "name": "post",
    "label": "Blog posts",
    "internal": false,
 //   ...

}
```
{ data-search-exclude }

To see which workflows have been implemented in Flotiq, you need to query the `GET` `/api/v1/workflow` endpoint.

### Transitioning objects in the workflow

Every content object created in the system will automatically be assigned the first state of the workflow, in the example above - `draft`. In order to transition the object to a different state use a simple `PUT` request to `/api/v1/workflow/:content_type/:object_id` endpoint with the following body:

```json
{
    "action":"_draft_review"
}
```
{ data-search-exclude }

### Verifying possible transitions of an object

If you'd like to verify what are the possible transitions of an object, given its current state - you can issue a `GET` request to `/api/v1/workflow/:content_type/:object_id`, the response will contain the current state of the object as well as possible transitions from that state:

```json
{
    "state": "public",
    "enabled_transitions": [
        {
            "name": "_public_archive",
            "froms": [
                "public"
            ],
            "tos": [
                "archive"
            ]
        }
    ]
}
```
{ data-search-exclude }

### Internal fields workflowPublishedAt and workflowPublicVersion

Every content object has `workflowPublishedAt` and `workflowPublicVersion` fields under the `internal` section. These fields contain information (such as `updatedAt` and `latestVersion`) about the last content object version in the public state.

!!! note
    If there are no content object versions in the `public` state, the `workflowPublishedAt` field will be set to `-1`, and the `workflowPublicVersion` field will be set to an empty string (`""`).

!!! note
    If the object itself is the latest `public` version, its `workflowPublishedAt` and `workflowPublicVersion` fields will point to the current object version's `updatedAt` and `latestVersion` fields. See the example below.

```json
{
    "id": "snipcart-584874",
    "name": "Gunpowder Temple Of Heaven",
    "image": [
        {
            "type": "internal",
            "dataUrl": "/api/v1/content/_media/_media-5e17192889e87"
        }
    ],
    "price": 22,
    "internal": {
        "createdAt": "2020-01-08T13:29:28+00:00",
        "deletedAt": "",
        "updatedAt": "2020-01-09T12:30:38+00:00",
        "contentType": "snipcart",
        "workflowState": "public",
        "latestVersion": 2,
        "workflowPublicVersion" : 2, 
        "workflowPublishedAt" : "2020-01-09T12:30:38+00:00",
    }
}
```
{ data-search-exclude }

!!! note
    When a content object is unpublished, all `workflowPublishedAt` and `workflowPublicVersion` fields pointing to this version will be set to `-1` and an empty string (`""`).

### Published content

The `public` state is a special state name, which teams can use in their workflows for an easy way to query for approved content. All Flotiq endpoints support a `x-visibility` header, which - if set to `public` - will force the endpoints to limit their work to content that is in the `public` state.
