<div class="breadcrumbs">
<a href="/">Docs</a> / <a href="/CLI/">CLI</a> / <a href="/CLI/importing-data/">Importing example data</a>
</div>

# Importing example data for Gatsby starters with Flotiq CLI

To importing example data for a Gatsby starter with Flotiq CLI you need a Flotiq account (you can [register here](http://editor.flotiq.com/register.html)), your "Read and write API key" (more about API keys [here](../API/index.md)), and a clone of one of our [Gatsby starters](#gatsby-starters).

The command looks like this:

```bash
flotiq import [flotiqApiKey] [projectName]
```

After running the command, you should have data imported to your Flotiq account.

### Parameters

`flotiqApiKey` - API key to your Flotiq account

`projectName` - project name or project path (if you wish to start or import data from the directory you are in, use `.`)

## Gatsby Starters

You can choose one of our starters:

* [Recipe website Gatsby starter](https://github.com/flotiq/gatsby-starter-recipes)
* [Event calendar Gatsby starter](https://github.com/flotiq/gatsby-starter-event-calendar)
* [Project portfolio Gatsby starter](https://github.com/flotiq/gatsby-starter-projects)
* [Simple blog Gatsby starter](https://github.com/flotiq/gatsby-starter-blog)
* [Gatsby and Snipcart boilerplate, sourcing products from Flotiq](https://github.com/flotiq/gatsby-starter-products)
* [Gatsby and Snipcart boilerplate, e-commerce and Flotiq, products with categories](https://github.com/flotiq/gatsby-starter-products-with-categories)
