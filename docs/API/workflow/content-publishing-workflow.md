title: Flotiq workflows - content publishing | Flotiq documentation
description: Flotiq support for custom workflows helps teams collaborate and produce quality content.

# Flotiq workflows

!!! note 
    Flotiq workflows can be customized in enterprise version only. 
    Reach out to us to discuss possible implementation.

Workflows are a powerful feature that helps teams collaborate and produce quality content. 
Flotiq implements workflows for all content types defined in the system, however the default 
workflow supports only a single state - `saved`. Every content object in the system carries a `workflowState` field under the `internal` section, see last line of the snippet below:

```
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

## Custom workflows

Custom workflows can be defined in Flotiq, for example a simple editorial workflow that introduces the following states:

- draft
- review
- public
- archive

with the following possible transitions

![](./images/publishing-workflow.svg)

can be used to help teams curate content, manage publication and archiving of content.

!!! hint
    Transitions are named using the following rule: `_fromState_toState`


### Changing the workflow of a Content Type Definition

Workflows are defined at the Content Type Definition level, in order to change the workflow of a Content Type Definition from the default one - execute a `PUT` update on the `/api/v1/internal/contenttype/:label` endpoint and provide the additional attribute pointing to the workflow identifier:

```
{
    "id": "d954df66-3623-11a4-ba9a-ca80993425cb",
    "name": "post",
    "label": "Blog posts",
    "internal": false,
    "workflowId":"publishing",

 //   ...

}
```

### Transitioning objects in the workflow

Every content object created in the system will automatically be assigned the first state of the workflow, in the example above - `draft`. In order to transition the object to a different state use a simple `PUT` request to `/api/v1/workflow/:content_type/:object_id` endpoint with the following body:

```
{
    "action":"_draft_review"
}
```

### Verifying possible transitions of an object

If you'd like to verify what are the possible transitions of an object, given its current state - you can issue a `GET` request to `/api/v1/workflow/:content_type/:object_id`, the response will contain the current state of the object as well as possible transitions from that state:

```
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
### Intenal fields workflowPublishedAt and workflowPublicVersion  
Every content object have `workflowPublishedAt` and `workflowPublicVersion`, field under the `internal` section. 
These fields contains informations (`updatedAt` and `latestVersion`) about, last content-object version in `public` state.

!!! note 
    If there is non content-object version in `public` state, its `workflowPublishedAt` and `workflowPublicVersion` fields be set to `null`

!!! note 
    If the object itself is latest `public` version, its `workflowPublishedAt` and `workflowPublicVersion` fields will point on the current object version `updatedAt` and `latestVersion` fields. See example below.      
```
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
!!! note 
    When content-object is unpublished, all  `workflowPublishedAt` and `workflowPublicVersion` fields pointing on this version, will be set to null   



### Published content

The `public` state is a special state name, which teams can use in their workflows for an easy way to query for approved content. All Flotiq endpoints support a `x-visibility` header, which - if set to `public` - will force the endpoints to limit their work to content that is in the `public` state.
