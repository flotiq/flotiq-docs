title: Custom Links | Flotiq documentation
description: This plugin allows to create custom links in each entity view.

This plugin will display a button with a link in the edit content object. The link will be supplemented with data from the currently edited object.
Thanks to this link, you will be able to get easy access to the preview of where the content is used.

## Installing the Custom Links plugin

Open up your profile menu and select `Plugins`.

![Flotiq plugins](images/profile-plugins.png){: .center .width25 .border}

On the next screen, click on the `Add to your plugins` button next to `Custom Links`.

![Adding Custom Links plugin to Flotiq](images/plugins-custom-links-1.png){: .center .width75 .border}

Next - fill in the details and click `Save changes` to finish your plugin setup.

![Setting up Custom Links in Flotiq](images/plugins-custom-links-2.png){: .center .width75 .border}

* URL Template - It's a place to enter the link template, e.g. `https://my-blog/post/{slug}`, where `slug` is the name of the content field of the type selected below. Instead of `{slug}`, you can use any field of a given content type, it is also possible to use nesting, e.g. `{internal.createdAt}`. However, the use of list type fields is not supported.

* Displayed Name Template - Any name that will be displayed on the link button.

* Content Type Definition - Select the content type to display the button only for the specified content type. If the content type is not selected, the button will be shown when editing each content object.

You're done. Now you will see `Link to current post` in Content Objects forms, the button  `https://my-blog/post/first-post`.

![Netlify build button in Flotiq editor](images/plugins-custom-links-3.png){: .center .width50 .border}


## Examples

### Using Custom Links plugin for preview links

One of the most common use cases for using this plugin is to add a direct link to a preview/staging environment  directly from the editor. Here's how you could set that up:

![Custom links plugin configuration for linking to a preview environment](images/plugins-custom-links-4.png){: .center .width50 .border}

### Creating links to pages using complex routing

Here's a bit more complex example, where the page routing requires to provide a URL with the name of a category *and* a slug of the current page:

![Custom links plugin with a more complex routing](images/plugins-custom-links-5.png){: .center .width50 .border}

if you use this configuration with an object similar to this

![Content object with category and slug](images/plugins-custom-links-6.png){: .center .width50 .border}

you will see a preview link that will lead you to `https://staging.site.com/office/best-office-chair`.
