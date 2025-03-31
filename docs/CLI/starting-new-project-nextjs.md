---
tags:
  - Developer
---

# Starting new Next.js project with Flotiq CLI

There are two main ways of starting Flotiq Next.js project with CLI:

- **Create your project from the ground up** - Using flotiq-nextjs-setup CLI you can start with Flotiq Next.js project framework with automatically generated SDK. To do so refer to our [NextJS Setup Guide](/docs/Universe/nextjs/nextjs-setup/).
- **Create your project using starter** - Flotiq starters are designed to streamline your web development process, providing you with predefined data model and customizable site for blog, portfolio and more. The guide below will guide you through the process of starting your project with one of the starters.

On top of using a starter that is ready to kick-start your project development, we recommend adding **Flotiq Node.js integration and SDK**. More on that in [Flotiq SDK section](#flotiq-sdk).

To start developing a new Next.js project with one of the Flotiq starters using [Flotiq CLI](./index.md) you need a Flotiq account (you can [register here](http://editor.flotiq.com/register?plan=1ef44daa-fdc3-6790-960e-cb20a0848bfa)) and your "Read and write API key" (more about API keys [here](../API/index.md)).

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

# Flotiq SDK

The Flotiq SDK is a powerful tool designed to simplify the integration of Flotiq content into your Next.js projects. It provides an auto-generated, type-safe API client tailored to your specific content types, allowing you to focus on building your application rather than dealing with low-level API requests.

## Installing Flotiq SDK

The best way to install the Flotiq SDK for your Next.js project is to use our flotiq-nextjs-setup CLI, which will automatically generate SDK for your content and integrate it in your project, add content cache revalidation endpoint, handle draft mode for unpublished content on Flotiq and more.

On how to setup Flotiq Next.js integration with the flotiq-nextjs-setup CLI refer to our [page about integrating Flotiq and Next.js with CLI](/docs/Universe/nextjs/nextjs-setup.md#flotiq-nextjs-setup).

If you prefer to just install Flotiq SDK and handle everything else by yourself, refer to the [Flotiq SDK page](/docs/API/generate-package.md).
