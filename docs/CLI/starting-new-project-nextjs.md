---
tags:
  - Developer
---

# Starting new Next.js project with Flotiq CLI

There are two main ways of starting Flotiq Next.js project with CLI:

- **Create your project from ground up** - Using flotiq-nextjs-setup CLI you can start with Flotiq Next.js project framework with automatically generated SDK. To do so refer to our [NextJS Setup Guide](/docs/Universe/nextjs/nextjs-setup/).
- **Create your project using starter** - Flotiq starters are designed to streamline your web development process, providing you with predefined data model and customizable site for blog, portfolio and more. The guide below will guide you through the process of starting your project with one of the starters.

To start develping new Next.js project with one of the Flotiq starters using [Flotiq CLI](./index.md) you need a Flotiq account (you can [register here](http://editor.flotiq.com/register.html)) and your "Read and write API key" (more about API keys [here](../API/index.md)).

The command looks like this:

```bash
flotiq start [projectName] [flotiqStarterUrl] [flotiqApiKey]
```
{ data-search-exclude }

After running the command, you should have a new project cloned with installed dependencies, data imported to your Flotiq account and started server with the project.

### Parameters

`projectName` - project name or project path (if you wish to start or import data from the current directory - use `.`)

`flotiqStarterUrl` - full link to Next.js starter, the list below

`flotiqApiKey` - API key to your Flotiq account

## NextJs Starters

* [Recipe website NextJs starter-2](https://github.com/flotiq/flotiq-nextjs-recipe-2) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-recipe-2` as the `flotiqStarterUrl`
* [Event calendar NextJs starter-2](https://github.com/flotiq/flotiq-nextjs-event-2) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-event-2` as the `flotiqStarterUrl`
* [Project portfolio NextJs starter-2](https://github.com/flotiq/flotiq-nextjs-portfolio-2) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-portfolio-2` as the `flotiqStarterUrl`
* [Simple blog NextJs starter-1](https://github.com/flotiq/flotiq-nextjs-blog-1) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-blog-1` as the `flotiqStarterUrl`
* [NextJs and Snipcart boilerplate, sourcing products from Flotiq-2](https://github.com/flotiq/flotiq-nextjs-shop-2) - to use this starter use: `https://github.com/flotiq/flotiq-nextjs-shop-2` as the `flotiqStarterUrl`

## Import example data

If you have cloned one of Next.js starters, you can import example data.

The command looks like this:

```bash
flotiq import [projectName] [flotiqApiKey]
```
{ data-search-exclude }

After running the command, you should have data imported to your Flotiq account.

### Parameters

`projectName` - project name or project path (if you wish to start or import data from the directory you are in, use `.`)

`flotiqApiKey` - API key to your Flotiq account
