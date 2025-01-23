---
tags:
  - Developer
---

title: Setting up a Flotiq Next.js project | Flotiq docs
description: Set up your Flotiq Next.js project using the CLI.

# Setting up Flotiq Next.js project

In this guide, we go over steps for easy setup for fresh Flotiq Next.js project using just a few CLI commands. If you wish to use a starter with predefined style and type of content, have a look at our [Next.js starters documentation page](/docs/Universe/nextjs/nextjs-starters/) instead.

## Prerequisites

1. [Flotiq account](https://editor.flotiq.com)
2. At least one Content Type in Flotiq*
3. Node.js version 20 or higher (you can use older node versions, but you may encounter issues during the setup process)

`* although in the setup process an example content type "blog_post" will be proposed, that will allow to quickly get acquainted with the flotiq nextjs project.`

## NextJS Project setup

Start the setup by initializing the Next.js project using the following npx command:

```bash
npx create-next-app@latest <path-to-nextjs-project>
```
{ data-search-exclude }

!!! Note
    Use `.` as `<path-to-nextjs-project>` if you want to setup the project in the directory that you are currently in.

The command above will have you choose some of the NextJS project specifications. Below you can see the table presenting you options supported by the Flotiq Next.js setup CLI tool:

| Feature                                  | Yes | No  |
|------------------------------------------|-----|-----|
| Next.js version >= 15                    | ✅  | ❌  |
| TypeScript?                              | ✅  | ✅  |
| ESLint?                                  | Optional | Optional |
| Tailwind CSS?                            | ✅  | ✅  |
| Code inside a `src/` directory?          | ✅  | ✅  |
| App Router?                              | ✅  | ❌  |
| Turbopack for `next dev`?                | Optional | Optional |
| Customized the import alias (`@/*`)?     | ✅  | ✅  |

Once you have your NextJS project setup, it's time to integrate it with Flotiq. Start by logging into your Flotiq account. It's important to stay authenticated during following steps. Then go to your project directory:

```bash
cd <path-to-nextjs-project>
```
{ data-search-exclude }

Now your Next.js project is ready to install Flotiq Next.js integration.

## Flotiq NextJS setup

Once your base Next.js framework is set, you can install Flotiq Next.js in it.

Start the setup by installing Flotiq's CLI for Next.js integration:

```bash
npm install -g flotiq-nextjs-setup
```
{ data-search-exclude }

And run the Flotiq Next.js setup process with the following command:

```bash
npx flotiq-nextjs-setup
```
{ data-search-exclude }

This command will guide you through the final steps of setting up your project. Notably it will:

* request access to your Flotiq account - if you have more than one space you can select the space that you wish to use for your project from dropdown
* ask you which one of your content types from your Flotiq account you wish to integrate into your project (or provide you with an example content type).
* generate SDK [read more about Flotiq SDK](/docs/API/generate-package/sdk-nodejs/).
* ask if you wish it to set up example page.
* generate `FLOTIQ_CLIENT_AUTH_KEY` in `.env.local` environment variables - a random string used for entering draft mode and cache revalidation.

Mind that the above process, especially generation of Flotiq SDK for your project, may take a while to finish.

Once the process is complete, your project is connected to your Flotiq data and ready to build!

# Usage

To start, run the following command to deploy your project locally:

```bash
npm run dev
```
{ data-search-exclude }

This will deploy your site on local address `http://localhost:3000` where you can preview its content (of course this address will change in staging or production environments, or if you used `--port` flag on application start).

If you haven't done so yet, it's time to add content to your Flotiq account. Go to `https://editor.flotiq.com`, navigate to content type that you've selected in your setup process and add content objects and by so doing, provide content for your site. In the editor, you can also preview your content object's data on your site, using the `Content Preview` plugin, which is automatically configured for your local environment (`http://localhost:3000`).

!!! Note
    Note that by default, your project will display only published content, so if you save your content object and keep them as `draft` this data will not be displayed.
    This can be changed by [setting up draft mode](#draft-mode).

Now that your Flotiq content is set up, it is available in your project. You can easily manipulate the data on your site using previously mentioned [Flotiq SDK](/docs/API/generate-package/sdk-nodejs/).

If you accepted the example page during setup, an example site like `app/blog_post/[slug]` will generate. Then if on your Flotiq account you have content objects of type `blog_post` with slug specified, you can preview their content at `http://localhost:3000/blog_post/<slug from your content object>`. In the generated `page.tsx` file you can see an example of how your Flotiq content is fetched and handled in your project with use of Flotiq SDK.

## Regenerating Flotiq SDK

If you change your content type definitions in Flotiq, you need to regenerate the Flotiq SDK to use the updated content model.

To regenerate Flotiq SDK run the following command:

```bash
npm exec flotiq-api-typegen
```
{ data-search-exclude }

If you change content types regularly and would like to regenerate the SDK automatically, run the following command to watch for changes and regenerate after each modification:

```bash
npm exec flotiq-api-typegen --watch
```
{ data-search-exclude }

## Content cache revalidation

Cache revalidation ensures that cached content is still valid and up-to-date, therefore in production environment, it is often best to revalidate each time you publish changes in your content.

To revalidate your content cache, you can use endpoint `POST http://localhost:3000/api/flotiq/revalidate` with header `x-editor-key=<your flotiq client auth key>` (the key should be automatically generated in your env.local file).

You can easily automate the above process, by adding a webhook in Flotiq, that will trigger on changes in your content, sending POST call to endpoint specified above. The webhook should be configured as follows:

* type: `async`
* url: `<Your sites domain>/api/flotiq/revalidate`
* actions: Create, Update, Delete
* content type definitions - any content types that should trigger the content cache revalidation, like `Blog Post` (leave empty for all content types to trigger the webhook)
* headers: `x-editor-key=<your flotiq client auth key>`

## Draft mode

To view unpublished Flotiq content, you can enable draft mode. To do so enter the following address: `http://localhost:3000/api/flotiq/draft?key=<your flotiq client auth key>` (the key should be automatically generated in your env.local file). This will set up a cookie in your browser, that will allow you to browse your content in draft mode. If you wish to exit the draft mode, enter the specified address again.

Additional query parameters you may specify include:

* `draft=true`|`draft=false` - whether the draft mode should be enabled or disabled
* `redirect` - where brwser should be redirected after the request. E.g. `draft=true&redirect=/post/123` will enable draft mode and redirect to `/post/123`

Refer to [Next.js Draft Mode](https://nextjs.org/docs/app/building-your-application/configuring/draft-mode) documentation to see how to implment code supporting draft mode.

# Conclusion

This documentation provides a comprehensive guide to setting up, using, and maintaining your project with Flotiq and NextJS. By following the steps outlined above, you can efficiently manage your content, integrate updates seamlessly, and ensure your site remains fast and reliable. Should you encounter any challenges, revisit this guide or consult Flotiq's official resources for further support. With these tools at your disposal, you're well-equipped to create and maintain a dynamic, content-rich site.
