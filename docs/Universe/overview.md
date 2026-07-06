---
tags:
  - Administrator
  - Developer
---

title: Flotiq deployment modes | Flotiq docs
description: Live and static modes for deploying your content.

# Deployment modes

!!! caution
    Gatsby Cloud was shut down by Netlify in 2023. If you use Gatsby, treat Gatsby Cloud-based workflows as legacy and deploy with supported platforms such as Netlify or Vercel.

Headless CMS systems are commonly used with JAMstack projects, which have 2 basic modes of deployment and operation:

* live - traditional, where the content is pulled from the CMS on demand, for example every time a user opens a website, this usually involves a tool that has SSR (server-side rendering) capabilities,
* static - using a static site generator (or SSG), where a full website is generated as HTML, content is pulled from CMS only during the build process.

## Live

In this mode each website visit is deducting your API quota and bandwidth. There are 2 factors that influence the bandwidth usage for image transfer:

* CDN cache - our CDN (Cloudflare) will cache the images on their edge locations across the globe, depending on how often you modify the images - this will result in a major decrease of the bandwidth you use on image traffic (read more [here](https://developers.cloudflare.com/cache/about/default-cache-behavior/)),
* Image resizing - you can use our [image transformation endpoint](https://flotiq.com/docs/API/media-library/#viewing-and-resizing-photos-returning-files) to specify the pixel size of the image you are serving in order to reduce the bandwidth required for your system.

This is how most CMS systems work, where the website is running on a server and responding to visitor’s requests.

### Advantages of running Live

Using this mode has the following key advantages:

* changes in the content can be immediately reflected on the website,
* it’s conceptually simpler to implement business logic,
* redeployment is required only when changes are made to the codebase.

### Disadvantages of running Live

There are some drawbacks of using the live mode:

* requires a server to run your website, which involves cost and maintenance effort
* changes in the content will be immediately reflected on the website ;-) - you may need additional logic to control the publication of content.

### Technologies that support live mode

All server-based technologies, e.g.:

* PHP with its web frameworks like Symfony or Laravel,
* Node.js, for example Express, Next.js and similar,
* Python’s Django and similar,
* and many more.

## Static

If you thought that live mode is the “traditional way”, you can think of the static as going back to the ancient times. In static mode all your content, including HTML and images, can be hosted from a CDN, without the need of using a server to run your backend. This, of course, has some serious limitations, but also some important benefits.

### Benefits of using a static website

* Cheaper to run - can be served directly from CDN or static file hosting (like AWS S3)
* Better performance, entire websites can be served from CDN edge,
* In general - safer as there is less potential for attack,
* Less taxing on the CMS system. If you’re using a static site generator - your monthly usage quotas will only be consumed during the website deployment.

### Drawbacks of running a static website

* There is no place to store your business logic - you have to use 3rd party services or build your own service for each use case where a static HTML file will not suffice,
* Content changes (as well as code changes) require a redeployment of the website, which you have to control.

### Technologies that support static mode

This list is quite a bit shorter as not all solutions have out-of-the-box support for static site generation, here are a few notable ones:

* Gatsby
* Nuxt

## Conclusions

The best deployment mode depends on your goals. Below are the three most common scenarios.

**Minimize cost:**

- Use a static site generator (Gatsby or Next.js) with a free-tier hosting platform (Netlify or Vercel) and the `<< plan_names.free >>` tier of Flotiq.
- Flotiq quotas are only consumed during deployment, not on each page visit.
- For non-static behavior — such as payments (Snipcart) or form processing (Flotiq Forms) — use third-party services.

**Maximize flexibility:**

- Use a server-side technology such as Next.js or Symfony.
- This gives you full control over business logic.
- Flotiq quota usage scales with your website traffic.

**Hybrid approach:**

- Serve a static site but make occasional API calls to Flotiq for frequently changing data (for example, product stock levels in an e-commerce store).

To get started quickly, use our Next.js (React) starters for your JAMstack projects.

Gatsby starters are still available as legacy examples.

## Related docs

- [Get Started with API](../API/get-started.md)
- [SDK overview](../SDK/overview.md)
- [Deep Dives overview](../Deep-Dives/index.md)
