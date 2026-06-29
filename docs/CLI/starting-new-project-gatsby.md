---
tags:
  - Developer
---

# Starting new Gatsby project with Flotiq CLI

!!! caution
    Gatsby starter workflows are now treated as legacy documentation.

    Gatsby Cloud was shut down by Netlify in 2023, so use Netlify or Vercel for Gatsby deployments.

To start a new Gatsby project with [Flotiq CLI](./index.md) you need a Flotiq account (you can [register here](http://editor.flotiq.com/register?plan=1ef44daa-fdc3-6790-960e-cb20a0848bfa)) and your "Read and write API key" (more about API keys [here](../API/index.md)).

The command looks like this:

```bash
flotiq start [directory] [url] [flotiqApiKey] [framework]
```
{ data-search-exclude }

After running the command, you should have a new project cloned with installed dependencies, data imported to your Flotiq account and started server with the project.

### Parameters

* `directory` - project name or project path (if you wish to start or import data from the current directory - use `.`)
* `url` - full link to Gatsby starter (see list below)
* `flotiqApiKey` - API key to your Flotiq account
* `framework` - optional, defaults to `gatsby`

### Flags

* `--framework` or `--fw` - choose `gatsby` or `nextjs`
* `--no-import` or `-n` - skip importing example objects

## Support and compatibility

!!! warning
    Before using a Gatsby starter in production, verify its maintenance status and dependency versions in the starter repository.

Flotiq Gatsby starters are reference projects that help you start quickly.
Depending on when a starter was last updated, you may need to update dependencies before production use.

Before production deployment:

* verify supported Node.js and Gatsby versions in the selected starter repository,
* install dependencies and run a clean build,
* test key user paths and plugin integrations in your environment.

Compatibility is validated per starter repository, not globally for all starters listed on this page.

## Gatsby Starters

You can choose one of our starters:

* [Recipe website Gatsby starter-1](https://github.com/flotiq/flotiq-gatsby-recipe-1) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-recipe-1` as the `flotiqStarterUrl`
* [Recipe website Gatsby starter-2](https://github.com/flotiq/flotiq-gatsby-recipe-2) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-recipe-2` as the `flotiqStarterUrl`
* [Event calendar Gatsby starter-1](https://github.com/flotiq/flotiq-gatsby-event-1) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-event-1` as the `flotiqStarterUrl`
* [Event calendar Gatsby starter-2](https://github.com/flotiq/flotiq-gatsby-event-2) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-event-2` as the `flotiqStarterUrl`
* [Project portfolio Gatsby starter-1](https://github.com/flotiq/flotiq-gatsby-portfolio-1) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-portfolio-1` as the `flotiqStarterUrl`
* [Project portfolio Gatsby starter-2](https://github.com/flotiq/flotiq-gatsby-portfolio-2) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-portfolio-2` as the `flotiqStarterUrl`
* [Simple blog Gatsby starter-1](https://github.com/flotiq/flotiq-gatsby-blog-1) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-blog-1` as the `flotiqStarterUrl`
* [Simple blog Gatsby starter-2](https://github.com/flotiq/flotiq-gatsby-blog-2) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-blog-2` as the `flotiqStarterUrl`
* [Gatsby and Snipcart boilerplate, sourcing products from Flotiq-1](https://github.com/flotiq/flotiq-gatsby-shop-1) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-shop-1` as the `flotiqStarterUrl`
* [Gatsby and Snipcart boilerplate, sourcing products from Flotiq-2](https://github.com/flotiq/flotiq-gatsby-shop-2) - to use this starter use: `https://github.com/flotiq/flotiq-gatsby-shop-2` as the `flotiqStarterUrl`

## Import example data

The `flotiq start` command automatically imports example data to your Flotiq account. If you need to import data separately, you can use the general-purpose `flotiq import` command for importing JSON data exports.

For more information on the `flotiq import` command, refer to [Migrating data between spaces](./migrating-data-between-spaces.md).
