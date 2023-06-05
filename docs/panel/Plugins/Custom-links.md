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



## That's it!

You're done. Now you will see `Link to current post` in Content Objects forms, the button leads to `https://my-blog/post/first-post`.

![Custom Links button in Flotiq editor](images/plugins-custom-links-3.png){: .center .width75 .border}
