---
tags:
  - Developer
---

# Custom Links

Custom Links add a button with a dynamic link to the content object form. The
link is filled in with data from the object currently being edited, giving you
quick access to wherever that content is used.

!!! note
    Custom Links were previously available as a plugin. They are now part of
    [Space Settings](index.md) and no longer require installing a plugin.

## Configuration

[![Custom Links](../images/space-settings/custom-link.png)](../images/space-settings/custom-link.png){: .border}

Use **Add link** to create a new custom link, and the trash icon to remove one.
Select a link to open its configuration.

[![Custom link configuration](../images/space-settings/custom-link-modal.png)](../images/space-settings/custom-link-modal.png){: .border}

- **Content types** - The content types this link appears for. Leave empty to
  show the link for all content types.
- **URL template** *(required)* - The link address, filled in with fields of
  the edited object, for example `https://example.com/post/{slug}`. Nested and
  list fields work the same way as in route templates,
  e.g. `{internal.createdAt}` or `{addresses[0].city}`.
- **Link name template** *(required)* - The label shown on the button. It can
  also include object fields, for example `Open {title}`.

## Usage

Once configured, the custom link shows up as a button on the content object
form. Its address and label are filled in with data from the object you are
editing, so it always points to the right place for the current entry.

[![Custom link button on the content object form](../Plugins/images/custom-links/simple-link-co-form.png)](../Plugins/images/custom-links/simple-link-co-form.png){: .border}

The link appears for the selected content types and is hidden while creating or
duplicating an object.

## Examples

### Linking to a preview environment

A common use case is a direct link to a preview or staging environment from the
editor. Configure a URL template that points to your preview site:

[![Custom link configuration for a preview environment](../images/space-settings/simple-routing-modal.png)](../images/space-settings/simple-routing-modal.png){: .border}

With an object like this:

[![Content object with a slug](../Plugins/images/custom-links/simple-routing-co-form.png)](../Plugins/images/custom-links/simple-routing-co-form.png){: .border}

you get a `green-plant` link leading to
`https://my-product.com/product/green-plant`.

### Complex routing

When a page URL needs several fields — for example a category *and* a slug —
combine them in the URL template:

[![Custom link configuration with complex routing](../images/space-settings/complex-routing-modal.png)](../images/space-settings/complex-routing-modal.png){: .border}

With an object like this:

[![Content object with category and slug](../Plugins/images/custom-links/complex-routing-co-form.png)](../Plugins/images/custom-links/complex-routing-co-form.png){: .border}

you get a link leading to `https://my-site.com/green-plant/15`.
