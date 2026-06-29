---
tags:
  - Developer
---

# Starting new Next.js project with Flotiq CLI

There are two main ways of starting Flotiq Next.js project with CLI:

- **Create your project from the ground up** - Using flotiq-nextjs-setup CLI you can start with Flotiq Next.js project framework with automatically generated SDK. To do so refer to our [Next.js setup guide](/docs/Universe/nextjs/nextjs-setup/).
- **Create your project using starter** - Flotiq starters are designed to streamline your web development process, providing you with predefined data model and customizable site for blog, portfolio and more. The guide below will guide you through the process of starting your project with one of the starters.

On top of using a starter that is ready to kick-start your project development, we recommend adding **Flotiq Node.js integration and SDK**. More on that in [Flotiq SDK section](#flotiq-sdk).

To start developing a new Next.js project with one of the Flotiq starters using [Flotiq CLI](./index.md) you need a Flotiq account (you can [register here](http://editor.flotiq.com/register?plan=1ef44daa-fdc3-6790-960e-cb20a0848bfa)) and your "Read and write API key" (more about API keys [here](../API/index.md)).

The command looks like this:

```bash
flotiq start [directory] [url] [flotiqApiKey] [framework]
```
{ data-search-exclude }

After running the command, you should have a new project cloned with installed dependencies, data imported to your Flotiq account and started server with the project.

### Parameters

* `directory` - project name or project path (if you wish to start or import data from the current directory - use `.`)
* `url` - full link to Next.js starter (see list below)
* `flotiqApiKey` - API key to your Flotiq account
* `framework` - optional, defaults to `nextjs`

### Flags

* `--framework` or `--fw` - choose `gatsby` or `nextjs`
* `--no-import` or `-n` - skip importing example objects

## Support and compatibility

!!! warning
    Before using a Next.js starter in production, verify its maintenance status and dependency versions in the starter repository.

Flotiq Next.js starters are reference projects that help you start quickly.
Depending on when a starter was last updated, you may need to update dependencies before production use.

For new projects, prefer the `flotiq-nextjs-setup` approach for Flotiq integration and SDK setup.
Use `flotiq start` starters as templates that can be adapted to your project requirements.

Before production deployment:

* verify supported Node.js and Next.js versions in the selected starter repository,
* install dependencies and run a clean build,
* test key user paths and integration points in your environment.

Compatibility is validated per starter repository, not globally for all starters listed on this page.

## Next.js Starters

* [Recipe website Next.js starter-2](https://github.com/flotiq/flotiq-nextjs-recipe-2) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-recipe-2` as the `flotiqStarterUrl`
* [Event calendar Next.js starter-2](https://github.com/flotiq/flotiq-nextjs-event-2) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-event-2` as the `flotiqStarterUrl`
* [Project portfolio Next.js starter-2](https://github.com/flotiq/flotiq-nextjs-portfolio-2) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-portfolio-2` as the `flotiqStarterUrl`
* [Simple blog Next.js starter-1](https://github.com/flotiq/flotiq-nextjs-blog-1) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-blog-1` as the `flotiqStarterUrl`
* [Next.js and Snipcart boilerplate, sourcing products from Flotiq-2](https://github.com/flotiq/flotiq-nextjs-shop-2) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-shop-2` as the `flotiqStarterUrl`

## Import example data

The `flotiq start` command automatically imports example data to your Flotiq account. If you need to import data separately, you can use the general-purpose `flotiq import` command for importing JSON data exports.

For more information on the `flotiq import` command, refer to [Migrating data between spaces](./migrating-data-between-spaces.md).

# Flotiq SDK

The Flotiq SDK is a powerful tool designed to simplify the integration of Flotiq content into your Next.js projects. It provides an auto-generated, type-safe API client tailored to your specific content types, allowing you to focus on building your application rather than dealing with low-level API requests.

## Installing Flotiq SDK

The best way to install the Flotiq SDK for your Next.js project is to use our flotiq-nextjs-setup CLI, which will automatically generate SDK for your content and integrate it in your project, add content cache revalidation endpoint, handle draft mode for unpublished content on Flotiq and more.

On how to setup Flotiq Next.js integration with the flotiq-nextjs-setup CLI refer to our [page about integrating Flotiq and Next.js with CLI](/docs/Universe/nextjs/nextjs-setup/#flotiq-nextjs-setup).

If you prefer to just install Flotiq SDK and handle everything else by yourself, refer to the [Flotiq SDK page](/docs/SDK/sdk-js-ts).
