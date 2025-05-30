---
tags:
  - Content Creator
---

title: Draft & Public
description: Draft & Public Mode is a feature that allows teams to manage different content variants in the CTD system

# Draft & Public

The Draft & Public mode is designed to manage the visibility of content objects in the system and facilitate the
publishing process.
When enabled, users can utilize statuses such as `draft`, `public`, `modified`, and `archived` to better organize
content and control its state.

This feature is disabled by default, and all saved content objects will have their status set to `public`.

## Available content statuses

Draft & Public provide a set of content statuses to help teams manage and organize their content. 
Below is a list of each status with a brief explanation:

- **Draft** – The default status for all newly created content objects.
- **Public** – Indicates content that is ready for production.
- **Modified** – When a content object with the `public` status is edited, a new `modified` version is created, while the existing `public` version remains unchanged.
- **Archived** – Assigned to content that has been withdrawn from the Public state.

![Content objects grid](../images/co-form/draftpublic/cto-grid.png){: .center .width75 .border}

!!! Note
    **In the Dashboard, all content types will be visible** regardless of their status, unlike in the API.
    Read more about [Draft & Public API](/docs/API/draft-public/draft-public).

### Mass publishing
In the content browser, objects of a type with draft & public mode enabled have access to bulk status change options.
![GridBatchPublishingActionMenu.png](../images/GridBatchPublishingActionMenu.png){: .center .width75 .border}

!!! Note
    A bulk status change to, for example, `public` will move all selected objects to that state, regardless of their current status.

### Publishing content

To make an object that satisfies all requirements available to all users, it must be made public.
This can be achieved by clicking the green **Publish** button located in the toolbar.   

![Publishing object](../images/co-form/draftpublic/publish-draft.png){: .center .width75 .border}

!!! Note
    Now object  will have the status `public` and will be visible, by default in the [listing API](/docs/API/draft-public/draft-public).

Or by selecting it on the content browser and clicking `Actions` and then `Publish` button:

![GridMassPublish](../images/GridMassPublish.png){: .center .width75 .border}


#### Cascading publication

When a Content Object is linked to others using Draft & Public mode, publishing actions can influence linked objects. 
When initiating the publishing process for such content, a confirmation modal will appear to guide the action. This modal presents two options:

* **Publish both the object and related objects** – Choosing this option will simultaneously publish the primary content object as well as all linked objects.
* **Publish the selected object only** – This option restricts the publishing action to the chosen object, leaving all associated linked objects unaffected.

![Cascading publication](../images/co-form/draftpublic/cascade-publish.png){: .center .width75 .border}

If the confirmation modal is **closed without making a selection**, no publication action will take place, and the current statuses of all objects will remain unchanged.

The modal appears when publishing an object and has linked objects in states other than public.

### Unpublishing content

If you wish to revert the public version to a draft to make some adjustments,
you can use the **Unpublish** button located in the Extras menu.

![Unpublishing object](../images/co-form/draftpublic/unpublishing.png){: .center .width75 .border}

!!! Note
    Now object will be reverted from `public` state into the `draft` and will not be visible, by default in the [listing API](/docs/API/draft-public/draft-public).

Or by selecting it on the content browser and clicking `Actions` and then `Unpublish` button:

![GridMassUnpublish.png](../images/GridMassUnpublish.png){: .center .width75 .border}


### Archiving content

If you wish to archive the public version, withdrawing it from the public state and marking it as archived,
you can use the **Archive** button located in the Extras menu.

![Archiving object](../images/co-form/draftpublic/archive.png){: .center .width75 .border}

!!! Note
    Now object  will have the status `archive` and will not be visible, by default in the [listing API](/docs/API/draft-public/draft-public).

Or by selecting it on the content browser and clicking `Actions` and then `Archive` button:

![GridMassArchive.png](../images/GridMassArchive.png){: .center .width75 .border}
