---
tags:
  - Developer
---

# Purging data from Flotiq account

You can remove all objects from your account with one command. It helps with testing different imports. Command needs additional confirmation. Content type definitions stay in place.

The command looks like this:

```bash
flotiq purge [flotiqApiKey]
```
{ data-search-exclude }

After running the command, all your objects should be removed.

### Parameters

* `flotiqApiKey` - read and write API key to your Flotiq account

**Flags**

* `--withInternal` or `--internal` - purge will also remove internal type objects like (`_media`)

* `--force` or `--f` - purge will remove data even if Content Types relations loop to each other.
