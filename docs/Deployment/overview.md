title: Deployment modes
description: Flotiq Deployment modes

# Deployment modes

Headless CMS systems are commonly used with JAMstack projects, which have 2 basic modes of deployment and operation:

* live - traditional, where the content is pulled from the CMS on demand, for example every time a user opens a website,

* static - using a static site generator, where a full website is generated as HTML, content is pulled from CMS only during the build process.

## Live

In this mode each website visit is deducting your API quota and bandwidth.
There are 2 factors that influence the bandwidth usage for image transfer:

* CDN cache - our CDN (Cloudflare) will cache the images on their edge locations across the globe,
depending on how often you modify the images - this will result in a major decrease of the bandwidth you use on image traffic (read more [here](https://developers.cloudflare.com/cache/about/default-cache-behavior/))
* Image resizing - you can use our [image transformation endpoint](https://flotiq.com/docs/API/media-library/#viewing-and-resizing-photos-returning-files) to specify the pixel size of the image you are serving in order to reduce the bandwidth required for your system.

This is how most CMS systems work, where the website is running on a server and responding to visitor’s requests.

### Advantages of running Live

Using this mode has the following key advantages:

* changes in the content can be immediately reflected on the website,

* it’s conceptually simpler to implement business logic, only code changes require a redeployment.

### Disadvantages of running Live

Using this mode has the following key advantages:

* changes in the content can be immediately reflected on the website,

* it’s conceptually simpler to implement business logic, only code changes require a redeployment.

### Disadvantages of running Live

There are some drawbacks of using the live mode:

* requires a server to run your website, which involves cost and maintenance effort

* changes in the content will be immediately reflected on the website ;-) - you may need additional logic to control the publication of content.

### Technologies that support live mode

All server-based technologies, e.g.:

* PHP with its web frameworks like Symfony or Laravel,
* Node.JS, for example Express, Next.JS and similar,
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

Depending on what you’re trying to achieve - one type might work better than the other.

If you’re trying to optimize the cost - it’s still possible to keep a website running for free using a static site generator like Gatsby and a free tier of Flotiq, but you will have to use 3rd party solutions for any non-static behavior (for example - handling payments through Snipcart, processing forms with Flotiq Forms, etc.). With a statically generated site your content is uploaded to a cloud-based file hosting service of your choice during the deployment and that is the only time when you use your Flotiq quotas.

If you’re looking for greater flexibility and you can accept the additional cost and complexity related to hosting your web application - you can choose one of the technologies supporting this, like Next.JS or Symfony. In this case - your website traffic will be proportional to the usage of your Flotiq quotas.

Of course - as usual, you can also think about building a hybrid solution, with a static site that runs occasional API calls to Flotiq to update the data that is frequently changing (for example to check stock in your e-commerce).

As always - let us know if you have any questions!
