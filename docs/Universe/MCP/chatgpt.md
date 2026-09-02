---
tags:
  - Developer
  - Content Creator
---

title: Flotiq MCP Server in ChatGPT | Flotiq docs
description: Connect your Flotiq content to ChatGPT using a custom MCP app.

# Flotiq MCP Server in ChatGPT

This guide shows how to connect the [Flotiq MCP Server](index.md) to ChatGPT as a custom app.

## Prerequisites

1. [Flotiq account](https://editor.flotiq.com){:target="_blank"}
2. ChatGPT plan that supports custom connectors

## Setup

### 1. Enable Developer mode

Go to [Settings &rarr; PLugins &rarr; Developer mode](https://chatgpt.com/#settings/Plugins){:target="_blank"} and turn
on **Developer mode**.

### 2. Open plugins configuration

Go back to **Settings &rarr; Plugins** and click **Browse plugins**.

![](../images/mcp/chatgpt-browse-plugins.png){: .center .width75 .border}

### 3. Create the plugin

Click **Create button**.

![](../images/mcp/chatgpt-add-plugin.png){: .center .width75 .border}

### 4. Enter the configuration

![](../images/mcp/chatgpt-create-plugin.png){: .center .width75 .border}

Confirm the risk notice and click **Create**.

### 5. Sign in to Flotiq

ChatGPT opens the Flotiq authorization page. Sign in with your Flotiq credentials, select
the [Space](../../panel/spaces.md) and the permission scope (`Read` or `Read & Write`), then click **Grant access**.

![](../images/mcp/chatgpt-sign-in.png){: .center .width75 .border}

## Using the tools

Start a new chat, make sure the Flotiq app is enabled in the message composer, and ask a question about your content:

![](../images/mcp/chatgpt-usage.png){: .center .width75 .border}

!!! Note
    ChatGPT decides on its own which tools to call.
    Read [Working safely with write tools](index.md#working-safely-with-write-tools) before letting it create or update
    content.

## Related docs

- [Flotiq MCP Server overview](index.md)
- [Universe overview](../overview.md)
- [Get Started with API](../../API/get-started.md)
