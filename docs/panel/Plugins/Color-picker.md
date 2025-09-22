---
tags:
  - Developer
---

title: Color picker plugin | Flotiq documentation
description: This plugin renders a color picker for selected text inputs.

The Flotiq Color Picker plugin transforms standard text input fields into intuitive color selection interfaces. This plugin provides a visual way to select and manage colors for your content, eliminating the need to manually enter hex color codes.

## Installing the Color picker plugin

Find in the right sidebar panel `Plugins` and select.

![Flotiq plugins](images/sidebar-plugins.png){: .center .width25 .border}

On the next screen, click the plus icon next to `Color picker` to install and enable the plugin.

![Install Color picker plugin](images/color-picker/install.png){: .center .width75 .border}

Once the plugin is enabled, click `Manage` to open the modal with the form.

![Manage Color picker](images/color-picker/manage.png){: .center .width75 .border}

Next, fill in the details and click `Save changes` to complete your plugin setup.

![Setting up Color picker in Flotiq](images/color-picker/color-picker-settings.png){: .center .width75 .border}

* Content Type - Defines the type of objects for which the color picker will be displayed.
* Fields - Choose at least one field to transform for provided Content Type.

!!! note "Color validation pattern"
    After saving the plugin, the selected fields in your Content Type Definition will be automatically updated with a validation pattern (regex) to ensure proper hex color code format. To maintain color validation functionality, please keep this pattern intact and avoid manual removal.

## Usage

Transformed text field into color picker:

![Color picker in Flotiq content object form](images/color-picker/input-color-picker.png){: .center .width75 .border}
