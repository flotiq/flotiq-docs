title: Custom Links | Flotiq documentation
description: This plugin allows to create custom links in each entity view.

This plugin will display a button with a link in the edit content object. The link will be supplemented with data from the currently edited object.
Thanks to this link, you will be able to get easy access to the preview of where the content is used.

## Installing the Custom Links plugin

Find in the right sidebar panel `Plugins` and select.

![Flotiq plugins](images/sidebar-plugins.png){: .center .width25 .border}

On the next screen, click the plus icon next to `Custom Links` to install and enable the plugin.

![Install Custom Links plugin](images/custom-links/install.png){: .center .width75 .border}

Once the plugin is enabled, click `Manage` to open the modal with the form.

![Manage Custom Links](images/custom-links/manage.png){: .center .width75 .border}

After the modal is opened, click `Add item`.

![Add Custom Link](images/custom-links/add.png){: .center .width75 .border}

Next, fill in the details and click `Save changes` to complete your plugin setup.

![Setting up Custom Links in Flotiq](images/custom-links/simple-link.png){: .center .width75 .border}

* URL template - It's a place to enter the link template, e.g. `https://my-blog/post/{slug}`, where `slug` is the name of the content field of the type selected below. Instead of `{slug}`, you can use any field of a given content type, it is also possible to use nesting, e.g. `{internal.createdAt}`. You can also use list fields: `{addresses[0].city}`.

* Link name template - Any name that will be displayed on the link button.

* Content types - Select the content types to display the button only for the specified content types. If the content types are not selected, the button will be shown when editing each content object.

You're done. Now you will see `Example page` in Content Objects forms with `http://example.com/` link.

![Custom links button in Flotiq editor](images/custom-links/simple-link-co-form.png){: .center .width75 .border}


## Examples

### Using Custom Links plugin for preview links

One of the most common use cases for using this plugin is to add a direct link to a preview/staging environment  directly from the editor. Here's how you could set that up:

![Custom links plugin configuration for linking to a preview environment](images/custom-links/simple-routing.png){: .center .width75 .border}

if you use this configuration with an object similar to this

![Content object with category and slug](images/custom-links/simple-routing-co-form.png){: .center .width75 .border}

you will see the `green-plant` link that will lead you to `https://my-product.com/product/green-plant`.

### Creating links to pages using complex routing

Here's a bit more complex example, where the page routing requires to provide a URL with the name of a category *and* a slug of the current page:

![Custom links plugin with a more complex routing](images/custom-links/complex-routing.png){: .center .width75 .border}

if you use this configuration with an object similar to this

![Content object with category and slug](images/custom-links/complex-routing-co-form.png){: .center .width75 .border}

you will see a preview link that will lead you to `https://my-site.com/green-plant/15`.
