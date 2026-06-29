---
tags:
  - Developer
---

# Purging data from Flotiq account

You can remove objects from your account or a selected space/Content Type Definition with one command. It helps with testing different imports. Command needs additional confirmation. Content type definitions stay in place unless explicitly removed.

!!! warning
    Treat `flotiq purge` as a destructive production operation.
    The command removes data in bulk, and this action should be considered irreversible in regular workflows.
    Always make a backup (for example export your data) before running purge on production.

The command looks like this:

```bash
flotiq purge [flotiqApiKey]
```
{ data-search-exclude }

After running the command, your objects should be removed.

### Parameters

* `flotiqApiKey` - read and write API key to your Flotiq account

### Flags

* `--spaceId` or `--space` - purge all data in a selected space
* `--ctdName` or `--ctd` - purge data for a selected Content Type Definition
* `--deleteSchema` or `--deleteCtd` - remove the CTD schema during CTD purge

## What is removed

* All Content Objects in the selected scope:
  * whole account (default)
  * selected space (`--space`)
  * selected Content Type Definition (`--ctd`)
* Content Type Definition schema only when `--deleteSchema` is used together with `--ctd`

## What is not removed by default

* Content Type Definition schemas (unless `--deleteSchema` is used)

## Recovery note

Deleted content objects are soft-deleted and retained for 60 days before permanent removal.
If recovery is needed, contact support at [support@flotiq.com](mailto:support@flotiq.com).
For details, see [Deleting Content Objects - Restoring deleted objects](/docs/API/content-type/deleting-co/#restoring-deleted-objects).

## Scope clarifications

* The purge command operates on Content Objects in the selected scope.
* The CLI purge command does not provide separate switches for:
  * already soft-deleted objects,
  * object version history,
  * media variants stored as part of media object data.
