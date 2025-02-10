---
tags:
  - Developer
---

# Flotiq UI Plugins Troubleshooting

## I get an error message when running `FlotiqPlugins.loadPlugin(id, url)`

```
Error while loading plugin script SyntaxError: Unexpected token '<'
```
{ data-search-exclude }

The most likely cause is that your plugin script is not loading properly and the remote server returns a 404 page. Check your plugin URL and make sure it returns a js file.

## I get `undefined` console message after pasting my plugin code to the console.

This is the standard message returned by the console when an executed script does not return any values. Don't worry about it.

## My plugin is not refreshing it's HTML content

Each time Flotiq renders a certain part of the UI, your plugin's `::render` is called. Make sure to update the content of your html element each time the render is executed. This may be either updating the content in the returned `div`, or rerendering react application.