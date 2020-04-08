title: Start selling online - Node.js e-commerce tutorial using Snipcart, Flotiq and Gatsby | Flotiq deep dives
description: Start selling products online instantly. Use our step-by-step tutorial on Snipcart, Gatsby and Flotiq and put your e-commerce live in 5 minutes.

# Start selling online with Snipcart, Flotiq, Gatsby and Heroku

This time, we'll dive deep into building e-commerce with Snipcart, Flotiq and Gatsby. We'll start with a fresh Flotiq account, build a Content Type Definition, hook it up with a Gatsby starter and finally - deploy it live using Heroku.

## Prepare your Flotiq account

There's a couple of simple steps that shouldn't take longer than 1 minute to complete.

### Register an account, 30 seconds
The first thing you'll need is a free Flotiq account, [register a free account in Flotiq](https://editor.flotiq.com/register.html). No payments, no credit cards, simply connect using your Github account or email. 

### Create your Content Type Definition, 30 seconds

The most crucial step - you have to tell Flotiq what kind of data you want to store in the system. What are the names of the content types and their properties. 

When you first log in - it's going to be pretty empty. No content, nothing. Head over to the `Type definitions` screen.

![Predefined Content Type Definitions](images/snipcart-gatsby-demo/upload_eb0f862f52d89aa0558842509818938a.png)


Here you find a list of simple boilerplate content types, which are a great start if you're in a hurry. 

Click on `Product` and then `Save`. You don't need to make any changes to get up and running with this project!

![Product content type body](images/snipcart-gatsby-demo/upload_2b69829cba0a8ad8d76416fb0bf7a6b0.png)

### Create your content, 2 minutes

For this project to work - you have to create a couple of products. In the left sidebar click on `Content` → `Products` and click the `Add new Product object` button.

![Adding new Content Object of type Product](images/snipcart-gatsby-demo/upload_999f5372a47637004f06bc1a00cc007e.png)

Enter the product detail.

![Product details in Flotiq](images/snipcart-gatsby-demo/upload_9832c93c03f6862b07fcb13f848962fe.png)

You can upload your images or use our awesome Unsplash integration - head over to the `Stock photos` tab in the Media Library and browse through thousands of beautiful images.

![Stock photos media library](images/snipcart-gatsby-demo/upload_a1a461706f319a31ce3f4ba1b58756dc.png)

Finally - click the `Save button`. 

Repeat for as many products as you want.

## Start your Gatsby project, 2 minutes

To make this extremely simple, we have prepared a Gatsby starter, that integrates with Flotiq as a data source for products. You will configure the project, install its dependencies and put the site live in no-time.

### Clone the repo


Start by cloning the repository:

```
git clone https://github.com/flotiq/gatsby-starter-products
```

### Configure Flotiq

Then, in the root folder of the repository create a file called `.env`. This file store the configuration for Flotiq and Snipcart. Put the following contents in the `.env` file:

```
GATSBY_FLOTIQ_BASE_URL="https://api.flotiq.com"
FLOTIQ_API_KEY="YOUR FLOTIQ API KEY"
```

You can find your Flotiq API keys in the user profile section of the interface:
![Flotiq user API key](images/snipcart-gatsby-demo/upload_61473eb050d5e4992b8c88eac716e52b.png)

We strongly recommend that you create a scoped API key, but for development, you can use the default Read Only key provided in the interface. 

### Check if it works!

It's as simple as that. You should be good to go. Install the NPM dependencies and start your gatsby project:

```
npm install
gatsby develop
```

You should now see your store at `http://localhost:8000`.

![Your store](images/snipcart-gatsby-demo/upload_18388a1968458357ff2eea62bb563adc.png)

## Start selling online

Yes, it is **that** simple. You're almost ready to start selling; the final part is to configure Snipcart properly.

### Configure Snipcart

Head over to [Snipcart](https://snipcart.com) and in your account - retrieve your Public API Key.

![Snipcart account api key settings](images/snipcart-gatsby-demo/upload_73bf9f96f1fadaf960e12e802833a26b.png)

Put that key in the `.env` file, so the file now looks like this:

```
GATSBY_FLOTIQ_BASE_URL="https://api.flotiq.com"
FLOTIQ_API_KEY="YOUR FLOTIQ API KEY"
SNIPCART_API_KEY="YOUR SNIPCART KEY"
```

and restart gatsby with `gatsby develop`.

Here's what you should now see, once you put an item in the cart:

![Your cart](images/snipcart-gatsby-demo/upload_82b4d268d923659550753caa762f02c2.png)

Once you complete the checkout steps, you'll see the final screen:

![Confirm order](images/snipcart-gatsby-demo/upload_632049a8ac4b39a5d39233d1e8414720.png)

But if you try to place the order from your local machine - it will end up looking like this:

![Your order cart content](images/snipcart-gatsby-demo/upload_0b4afe702b39d742e65fe8bf652a517f.png)

So - if you want to test the integration entirely - it's time to put this site live!

## Putting the website live using Heroku, 2 minutes

To make it super simple - we've prepared a button, that immediately put your project live on the Internet. 

Press the button!
  [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/flotiq/gatsby-starter-products)
  
Once you log in to Heroku (you can use a free account for that) - you have to pick a domain name for your project. We used `snipcart-flotiq`.
![Name and Region settings in Heroku](images/snipcart-gatsby-demo/upload_f7b021894467811e477eae8c3a3190f9.png)

and then copy the details from your `.env` file in the input fields 
![Application Configuration in Heroku](images/snipcart-gatsby-demo/upload_e88ab376e585bfdf413351b01898f9f7.png)

and hit `Deploy app`. In a minute (or two) - your app is live!
![Deploy App to Heroku button](images/snipcart-gatsby-demo/upload_0e11e37662064ad43e0fc994f4cf7401.png)



### Provide the domain name in Snipcart

While you're waiting for the deployment to finish - go to your Snipcart profile page and configure your domain name:

![Provide domain name in Snipcart](images/snipcart-gatsby-demo/upload_b9ba70e10596a6c60ec648a41eb1ee4c.png)

### Verify the result

Result? You've successfully placed an order!

![Order Result](images/snipcart-gatsby-demo/upload_5c0836387a79f4dc5e187d30fef345c9.png)


And you immediately see it in Snipcart, too.

![Snipcart Order](images/snipcart-gatsby-demo/upload_1a5a590dd6e2fa214c221305e11f8b13.png)


## Conclusions

You've successfully built and deployed an end-to-end e-commerce platform using no code, thanks to the tools and templates provided by Flotiq, Snipcart and Gatsby. While there are still many important things to consider before you launch your e-commerce - this is a great way to minimize the cost and effort required on the technical side.

As always - let us know how it worked for you!