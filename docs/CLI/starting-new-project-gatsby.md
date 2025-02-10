---
tags:
  - Developer
---

# Starting new Gatsby project with Flotiq CLI

To start a new Gatsby project with [Flotiq CLI](./index.md) you need a Flotiq account (you can [register here](http://editor.flotiq.com/register.html)) and your "Read and write API key" (more about API keys [here](../API/index.md)).

The command looks like this:

```bash
flotiq start [projectName] [flotiqStarterUrl] [flotiqApiKey]
```
{ data-search-exclude }

After running the command, you should have a new project cloned with installed dependencies, data imported to your Flotiq account and started server with the project.

### Parameters

`projectName` - project name or project path (if you wish to start or import data from the current directory - use `.`)

`flotiqStarterUrl` - full link to GatsbyJs starter, the list below

`flotiqApiKey` - API key to your Flotiq account

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

If you have cloned one of Gatsby starters, you can import example data.

The command looks like this:

```bash
flotiq import [projectName] [flotiqApiKey]
```
{ data-search-exclude }

After running the command, you should have data imported to your Flotiq account.

### Parameters

`projectName` - project name or project path (if you wish to start or import data from the directory you are in, use `.`)

`flotiqApiKey` - API key to your Flotiq account
