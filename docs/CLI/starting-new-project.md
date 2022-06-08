# Starting new Gatsby project with Flotiq CLI

To start a new Gatsby project with Flotiq CLI you need a Flotiq account (you can [register here](http://editor.flotiq.com/register.html)) and your "Read and write API key" (more about API keys [here](../API/index.md)).

The command looks like this:

```bash
flotiq start [projectName] [flotiqStarterUrl] [flotiqApiKey]
```

After running the command, you should have new project cloned with installed dependencies, data imported to your Flotiq account and started server with the project.

### Parameters

`projectName` - project name or project path (if you wish to start or import data from current directory - use `.`)

`flotiqStarterUrl` - full link to GatsbyJs starter, the list below

`flotiqApiKey` - API key to your Flotiq account

## Gatsby Starters

You can choose one of our starters:

* [Recipe website Gatsby starter](https://github.com/flotiq/gatsby-starter-recipes) - to use this starter use: `https://github.com/flotiq/gatsby-starter-recipes` as the `flotiqStarterUrl`
* [Event calendar Gatsby starter](https://github.com/flotiq/gatsby-starter-event-calendar) - to use this starter use: `https://github.com/flotiq/gatsby-starter-event-calendar` as the `flotiqStarterUrl`
* [Project portfolio Gatsby starter](https://github.com/flotiq/gatsby-starter-projects) - to use this starter use: `https://github.com/flotiq/gatsby-starter-projects` as the `flotiqStarterUrl`
* [Simple blog Gatsby starter](https://github.com/flotiq/gatsby-starter-blog) - to use this starter use: `https://github.com/flotiq/gatsby-starter-blog` as the `flotiqStarterUrl`
* [Gatsby and Snipcart boilerplate, sourcing products from Flotiq](https://github.com/flotiq/gatsby-starter-products) - to use this starter use: `https://github.com/flotiq/gatsby-starter-products` as the `flotiqStarterUrl`
* [Gatsby and Snipcart boilerplate, e-commerce and Flotiq, products with categories](https://github.com/flotiq/gatsby-starter-products-with-categories) - to use this starter use: `https://github.com/flotiq/gatsby-starter-products-with-categories` as the `flotiqStarterUrl`
