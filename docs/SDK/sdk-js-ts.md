---
tags:
  - Developer
---

title: Flotiq JavaScript / TypeScript SDK
description: Flotiq provides SDKs, or client libraries, to access your Content, but if you would like to build your own - you can use the OpenAPI compatible schema to generate clients and servers for multiple languages.

# Flotiq JavaScript / TypeScript SDK

The official SDK for integrating your JavaScript and TypeScript applications with the Flotiq Headless CMS.
[@flotiq/flotiq-api-sdk](https://www.npmjs.com/package/@flotiq/flotiq-api-sdk) offers a fully-typed,
developer-friendly client for interacting with your Flotiq content via REST API.
It makes working with structured content effortless and enables type-safe development from day one.

You can use the SDK in modern frontend frameworks such as Next.js, React, Astro, or any other JavaScript/TypeScript-based project.

Key features:

- Seamless integration with TypeScript and JavaScript
- Full support for type generation based on your content model
- Built-in support for content listing, filtering, pagination, search, and more
- Supports hydration of relations between content types
-️ Contains built-in helpers like image URLs generator
- Middleware support for request customization


## Getting started


To get started with the Flotiq JavaScript/TypeScript SDK, follow the below steps.

1. Install the SDK with: `npm install @flotiq/flotiq-api-sdk`
2. And (optionally) generate TypeScript types for your custom content types:
    1. Create `.env` file and add `FLOTIQ_API_KEY` env variable inside
    2. Run the type generation command: `npm exec flotiq-api-typegen`

With this setup, your codebase will benefit from type safety, better editor support,
and clear alignment with your content model in Flotiq.

!!! Note
    See the [@flotiq/flotiq-api-sdk](https://www.npmjs.com/package/@flotiq/flotiq-api-sdk) package documentation for
    how to get started with Yarn and explore other installation options.


## Basic usage

Here's a simple example of how to use the SDK to fetch a list of product objects in TypeScript from your Flotiq account:

```typescript
import { Flotiq } from '@flotiq/flotiq-api-sdk';

const api = new Flotiq(); // Will read FLOTIQ_API_KEY from process.env

const productsList = await api.content.products.list();
console.log(productsList.data); // Will return typed array of products
```
{ data-search-exclude }

If you want to fetch only selected objects, you can use filters, pagination, and sorting options.
Below is an example of listing products filtered by name:

```typescript
import { Flotiq } from '@flotiq/flotiq-api-sdk';

const api = new Flotiq(); // Will read FLOTIQ_API_KEY from process.env
const filteredList = await api.content.products.list({
        page: 1,
        limit: 10,
        orderBy: "name",
        orderDirection: "asc",
        filters: {
            name: {
                type: "contains",
                filter: "Example",
            },
        },
    });
console.log(filteredList.data); // Will return typed array of products
```
{ data-search-exclude }

The SDK also supports other common operations such as get, create, update, patch,
and delete for managing your content objects.
These methods make it easy to retrieve a single entry, add new data, modify existing records,
or remove content directly through the API.


## Full SDK reference

For a full list of supported methods, options, features, examples in JavaScript and TypeScript go to the 
[@flotiq/flotiq-api-sdk](https://www.npmjs.com/package/@flotiq/flotiq-api-sdk) 



## Next.js integration

If you're building with **Next.js**, integrating Flotiq can be done in seconds.

[`flotiq-nextjs-setup`](https://www.npmjs.com/package/flotiq-nextjs-setup) is a dedicated CLI tool
that scaffolds a Flotiq-powered Next.js project with just one command. 
It installs the official SDK, sets up content-related routes, and configures a preview plugin
— everything you need to get started quickly.

This is the fastest way to create a **type-safe**, **content-aware** Next.js app using Flotiq as your headless CMS.

What it does:

- Installs the official SDK: [`@flotiq/flotiq-api-sdk`](https://www.npmjs.com/package/@flotiq/flotiq-api-sdk)
- Sets up a preview mode for your Next.js app using draftMode.
- Adds the **Content Preview plugin** for draft previews.
- Generates dynamic pages for your existing Content Types.

Learn more about [`flotiq-nextjs-setup`](https://www.npmjs.com/package/flotiq-nextjs-setup) in its npm package documentation.