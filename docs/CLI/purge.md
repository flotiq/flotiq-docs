# Purging data from Flotiq account

You can remove all objects from your account with one command. It helps with testing different imports. Command needs additional confirmation. Content type definitions stay in place.

The command looks like this:

```bash
flotiq purge [flotiqApiKey] [options]
```

After running the command, all your objects should be removed.

### Parameters

`flotiqApiKey` - API key to your Flotiq account

`options` - additional options for the command:

* `withInternal=1` - remove also media objects
