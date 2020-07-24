# Migrate any WordPress content to Flotiq

To migrate content from any WordPress site with Flotiq CLI you need a Flotiq account (you can [register here](http://editor.flotiq.com/register.html)) and your "Read and write API key" (more about API keys [here](../API/index.md)).

The command looks like this:

```bash
flotiq wordpress-import [apiKey] [wordpressUrl]
```

After running the command, you should have new content types added to your Flotiq account that was imported from Wordpress site.

### Parameters

`apiKey` - API key to your Flotiq account

`wordpressUrl` - full link to WordPress site